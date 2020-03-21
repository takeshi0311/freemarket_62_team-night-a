require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  describe 'GET #search' do
    it "returns a 200 response" do
      get :search
      expect(response).to have_http_status "200"
    end
    
    it "renders the :search template" do
        get :search
        expect(response).to render_template :search
    end
  end

end
