require 'rails_helper'

RSpec.describe ReviewershipsController, type: :controller do
  let(:github_user) { double(login: "alice", token: "abc123") }

  describe "POST #create" do
    it "returns http success" do
      allow(controller).to receive(:github_user).and_return(github_user)
      allow_any_instance_of(Reviewership).to receive(:ensure_webhook_installed!)
      allow_any_instance_of(Reviewership).to receive(:ensure_bot_permissions!)
      post :create, reviewership: {repo: {name: "alice/website"}}
      expect(response).to redirect_to(profile_path)
    end
  end

end
