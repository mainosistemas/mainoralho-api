require "rails_helper"

RSpec.describe "Sprints", type: :request do
  describe "SHOW /sprints" do
    context "when user is logged in" do
      let(:project) { create(:project, owner: user) }
      let(:user) { create(:user) }
      let!(:sprint) { create(:sprint, owner: user, project: project) }

      it "returns status code 200" do
        get "/sprints/#{sprint.id}", headers: auth_token(user)
        expect(response).to have_http_status(200)
      end
    end
  end
end