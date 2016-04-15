require 'rails_helper'

describe UsersController do
  before do
    @user = FactoryGirl.create(:user, first_name: 'User', last_name: 'Userson', mobile_number: '0727777777', password: 'secret')
  end

  context 'when not signed in' do
    before do
      session[:user_id] = nil
    end

    it 'cannot access edit' do
      get :edit, id: @user

      expect(response).to redirect_to(new_session_url)
    end

    it 'cannot access update' do
      patch :update, id: @user

      expect(response).to redirect_to(new_session_url)
    end

    it 'cannot access destroy' do
      delete :destroy, id: @user

      expect(response).to redirect_to(new_session_url)
    end
  end

  context 'when signed in as the wrong user' do
    before do
      @wrong_user = FactoryGirl.create(:user, mobile_number: '0791234567')
      session[:user_id] = @wrong_user.id
    end

    it 'cannot edit another user' do
      get :edit, id: @user

      expect(response).to redirect_to(root_url)
    end

    it 'cannot update another user' do
      patch :update, id: @user

      expect(response).to redirect_to(root_url)
    end

    it 'cannot destroy another user' do
      delete :destroy, id: @user

      expect(response).to redirect_to(root_url)
    end
  end
end
