require 'rails_helper'
require 'test_helper'


RSpec.describe CheckpointsController do

    describe "GET checkpoints/index" do
        it "renders a succesful response" do
          get :index
          expect(response).to be_successful
        end
    end

    describe "GET checkpoints/new" do
        it "renders a successful response" do
          get :new
          expect(response).to be_successful
        end
    end

    describe "GET checkpoints/:id/edit" do
        it "renders a successful response" do
            checkpoint = Checkpoint.new
            expect(Checkpoint).to receive(:find).with('1').and_return(checkpoint)
            get :edit, params: { id: 1 }
            expect(response).to be_successful
        end
    end

    describe "GET checkpoints/destroy" do
        it "renders a successful response" do
            checkpoint = Checkpoint.new
            expect(Checkpoint).to receive(:find).with('1').and_return(checkpoint)
            get :destroy, params: { id: 1 }
        end
    end
end