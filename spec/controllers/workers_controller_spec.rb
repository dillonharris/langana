require 'rails_helper'

RSpec.describe WorkersController, type: :controller do
  before do
    @worker = FactoryGirl.create(:worker, first_name: "worker", last_name: "Workerson", mobile_number: "0727777777", password: "secret")
  end

  context "when not signed in" do

    before do
      session[:user_id] = nil
    end

    it "cannot access edit" do
      get :edit, id: @worker

      expect(response).to redirect_to(new_session_url)
    end

    it "cannot access update" do
      patch :update, id: @worker

      expect(response).to redirect_to(new_session_url)
    end

    it "cannot access destroy" do
      delete :destroy, id: @worker

      expect(response).to redirect_to(new_session_url)
    end

  end

  context "when signed in as the wrong worker" do

    before do
      @wrong_worker = FactoryGirl.create(:worker, mobile_number: "0791234567")
      session[:worker_id] = @wrong_worker.id
    end

    it "cannot edit another worker" do
      get :edit, id: @worker

      expect(response).to redirect_to(root_url)
    end

    it "cannot update another worker" do
      patch :update, id: @worker

      expect(response).to redirect_to(root_url)
    end

    it "cannot destroy another worker" do
      delete :destroy, id: @worker

      expect(response).to redirect_to(root_url)
    end

  end

end
