require 'rails_helper'

RSpec.describe "Api::People", type: :request do
  describe "GET /api/people" do
    it "works! (now write some real specs)" do
      get api_people_index_path
      expect(response).to have_http_status(200)
    end
  end
end
