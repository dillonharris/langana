require 'rails_helper'

describe UsersController do

  before do
    @user = User.create!(user_attributes)
  end

  context "when not signed in" do

    before do
      session[:user_id] = nil
    end

    it "cannot access edit" do
      get :edit, id: @user

      expect(response).to redirect_to(new_session_url)
    end

    it "cannot access update" do
      patch :update, id: @user

      expect(response).to redirect_to(new_session_url)
    end

    it "cannot access destroy" do
      delete :destroy, id: @user

      expect(response).to redirect_to(new_session_url)
    end

  end
end