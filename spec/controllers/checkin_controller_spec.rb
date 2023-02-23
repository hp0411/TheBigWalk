require 'rails_helper'
require 'test_helper'
require 'spec_helper'

RSpec.describe CheckinController do
  describe '#index' do
    it 'fetches checkpoints from the checkpoint service' do
      expect(CheckpointsService).to receive(:get_list_of_checkpoints).with('long').and_return([])
      get :index, params: { walk_type: 'long' }
    end
  end

  describe '#create (check in)' do
    context 'the checkpoint is far away' do
      it 'redirects with notice when ' do
        expect(CheckpointsService).to receive(:checkin).and_return(true)
        checkpoint = instance_double('Checkpoint')
        expect(checkpoint).to receive(:lat).and_return(100)
        expect(checkpoint).to receive(:lon).and_return(200)
  
        expect(Checkpoint).to receive(:where).with(
          name: 'some_name',
          walk_type: 'long'
        ).and_return([checkpoint])
  
        post :create, params: { 
          checkpoint: 'some_name', 
          participant_numbers: 1, 
          latitude: 5, 
          longitude: 6,
          walk_type: 'long'
        }
  
        # This line uses the redirect_to expecation from this page: https://stackoverflow.com/questions/23922934/rspec-testing-redirect-to-url-with-get-params
        # expect(response.location).to eq('Test checkpoint')
        expect(response.location.split('8373487')[0]).to eq('http://test.host/checkin?checkpoint=some_name&errors%5B%5D=You+are+too+far+from+the+checkpoint.+Distance+to+checkpoint%3A+')
      end
    end
    
    context 'cehckpoint is close' do
      it 'redirects with success when the checkpoint is far away' do
        expect(CheckpointsService).to receive(:checkin).and_return(true)
        checkpoint = instance_double('Checkpoint')
        expect(checkpoint).to receive(:lat).and_return(5)
        expect(checkpoint).to receive(:lon).and_return(6)
  
        expect(Checkpoint).to receive(:where).with(
          name: 'some_name',
          walk_type: 'long'
        ).and_return([checkpoint])
  
        post :create, params: { 
          checkpoint: 'some_name', 
          participant_numbers: 1, 
          latitude: 5, 
          longitude: 6,
          walk_type: 'long'
        }
  
        # This line uses the redirect_to expecation from this page: https://stackoverflow.com/questions/23922934/rspec-testing-redirect-to-url-with-get-params
        expect(response).to redirect_to('http://test.host/checkin?checkpoint=some_name&success=Successfully+checked+in+to+checkpoint+some_name')
      end
    end
    

    it 'calculates distance to selected checkpoint' do
      expect(CheckpointsService).to receive(:get_list_of_checkpoints).with('long').and_return([])
      get :index, params: { walk_type: 'long' }
    end
  end
end