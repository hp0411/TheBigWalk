require 'spec_helper'
require 'epi_deploy/stages_extractor'
require 'epi_deploy/release'

class MockGit
  def initialize(on_primary_branch: true, pending_changes: false)
    @on_primary_branch = on_primary_branch
    @pending_changes = pending_changes
  end
  def add(files); end
  def on_primary_branch?; @on_primary_branch; end
  def pending_changes?; @pending_changes; end
  def short_commit_hash; 'abc1234'; end
  def commit(msg); end
  def tag(name); end
  def push(opts = {}); end
  def pull; end
  def change_branch_commit(branch, commit); end
  def current_branch; 'main'; end
end

describe EpiDeploy::Release do

  let(:git_wrapper) { MockGit.new }
  before do
    allow(subject).to receive_messages(git_wrapper: git_wrapper, app_version: double(bump!: 42, version_file_path: ''))
  end

  describe "#create!" do
    describe "preconditions" do
      it "can only be done on the primary branch" do
        allow(subject).to receive_messages(git_wrapper: MockGit.new(on_primary_branch: false))
        expect(subject).to receive(:print_failure_and_abort).with('You can only create a release on the main or master branch. Please switch to main or master and try again.')

        expect { subject.create! }.to_not raise_error
      end

      it "errors when pending changes exist" do
        allow(subject).to receive_messages(git_wrapper: MockGit.new(pending_changes: true))
        expect(subject).to receive(:print_failure_and_abort).with('You have pending changes, please commit or stash them and try again.')

        expect { subject.create! }.to_not raise_error
      end
    end

    it "performs a git pull to ensure code is the latest" do
      allow(subject).to receive_messages(bump_version: nil)
      expect(git_wrapper).to receive(:pull)

      expect { subject.create! }.to_not raise_error
    end

    it "stops with a warning message when a git pull fails (eg. merge errors)" do
      allow(subject).to receive_messages(bump_version: nil)
      expect(git_wrapper).to receive(:pull)

      expect { subject.create! }.to_not raise_error
    end

    it "bumps the version number" do
      app_version = double version_file_path: ''
      allow(subject).to receive_messages(app_version: app_version)
      expect(app_version).to receive(:bump!)

      expect { subject.create! }.to_not raise_error
    end

    it "commits the new version number" do
      allow(subject).to receive_messages bump_version: 42
      expect(git_wrapper).to receive(:commit).with('Bumped to version 42 [skip ci]')

      expect { subject.create! }.to_not raise_error
    end

    it "creates a tag in the format YYYYmonDD-HHMM-CommitRef-version for the new commit" do
      allow(subject).to receive_messages bump_version: 42
      now = Time.new 2014, 12, 1, 16, 15
      allow(Time).to receive_messages now: now
      expect(git_wrapper).to receive(:tag).with('2014dec01-1615-abc1234-v42')

      expect { subject.create! }.to_not raise_error
    end

    it "pushes the new version to primary branch to reduce the chance of version number collisions" do
      allow(subject).to receive_messages bump_version: 42
      expect(git_wrapper).to receive(:push)

      expect { subject.create! }.to_not raise_error
    end
  end

  describe "#deploy!" do
    it "runs the capistrano deploy command for each of the environments given" do
      Dir.chdir(File.join(File.dirname(__FILE__), '../..', 'fixtures')) do
        expect(Kernel).to receive(:system).with('bundle exec cap demo deploy').and_return(true)
        expect(Kernel).to receive(:system).with('bundle exec cap production deploy_all').and_return(true)

        expect { subject.deploy! %w(demo production) }.to_not raise_error
      end
    end

  end

end
