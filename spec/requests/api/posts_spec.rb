require 'rails_helper'

RSpec.describe "Api::Posts", type: :request do
  describe "GET /api/posts" do
    it "works! (now write some real specs)" do
      get api_posts_index_path
      expect(response).to have_http_status(200)
    end
  end
end
