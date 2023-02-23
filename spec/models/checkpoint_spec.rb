require "test_helper"

RSpec.describe Checkpoint do
    describe '#create' do
        it "creates a new checkpoint " do
            checkpoint = described_class.new(name: 'Test checkpoint', attachment: 'test', description: 'test description', lat: 53.1, lon: 1.7)
            expect(checkpoint.name).to eq('Test checkpoint')
        end
    end
    
    describe '#new' do
        it "gets list of long walk checkpoints  " do
            checkpoints = CheckpointsService.get_list_of_checkpoints("long")
            expect(checkpoints.length()).to eq(21)
        end

        it "gets list of short walk checkpoints  " do
            checkpoints = CheckpointsService.get_list_of_checkpoints("short")
            expect(checkpoints.length()).to eq(12)
        end

    end
end