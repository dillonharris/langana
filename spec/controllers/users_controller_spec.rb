require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET #index' do
    let(:users) { create_list :user, 2 }

    before :each do
      get :index
    end

    it 'returns a list of all the users' do
      expect(assigns(:users)).to eq users
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before :each do
      log_in user
      get :show, id: user.id
    end

    context 'confirmed user' do
      let(:user) { create :user }

      it 'assigns the user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders the show template' do
        expect(response).to render_template :show
      end
    end

    context 'unconfirmed user' do
      let(:user) { create :user, confirmed_at: nil }

      it 'redirects to the confirm_user_path' do
        expect(response).to redirect_to confirm_user_path(user)
      end

      it 'does not render the show template' do
        expect(response).not_to render_template :show
      end
    end
  end

  describe 'GET #new' do
    before :each do
      get :new
    end

    it 'user should be a new record' do
      expect(assigns(:user)).to be_a_new_record
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    let(:create_user) { post :create, user: params }

    context 'with valid attributes' do
      let(:params) { attributes_for :user }

      # TODO These two specs fail because of this ERROR VCR::Errors::UnhandledHTTPRequestError: due to Since service KEYS
      xit 'creates a new user' do
        expect{ create_user }.to change(User, :count).by(1)
      end

      xit 'redirects to the confirm_user_path' do
        expect(create_user).to redirect_to confirm_user_path(User.last)
      end
    end

    context 'with invalid attributes' do
      let(:params) { attributes_for :user, first_name: nil, last_name: nil, password: 'xxx' }

      it 'should not create a new user' do
        expect{ create_user }.to change(User, :count).by(0)
      end

      it 'renders an alert flash message' do
        create_user
        expect(flash[:alert]).not_to be_nil
      end

      it 'renders the new template' do
        expect(create_user).to render_template :new
      end
    end
  end

  describe 'GET #confirm' do
    let(:user) { create :user, confirmed_at: nil }

    before :each do
      log_in user
      get :confirm, id: user.id
    end

    it 'assigns the user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders the confirm template' do
      expect(response).to render_template :confirm
    end
  end

  describe 'POST #verify_confirmation' do
    before :each do
      log_in user
      post :verify_confirmation, id: user.id, user: params
    end

    context 'user with confirmation attempts more than 9 times' do
      let(:user) { create :user, confirmed_at: nil, confirmation_attempts: 10 }
      let(:params) { attributes_for :user }

      it 'redirects to the confirm_user_path' do
        expect(response).to redirect_to confirm_user_path(user)
      end

      it 'renders an alert flash message' do
        expect(flash[:alert]).to eq 'You have typed in the wrong code too many times, please try again tomorrow'
      end
    end

    context 'BCrypt mobile salt' do
      # TODO write test here
    end

    context 'unconfirmed user with incorrect confirmation code' do
      let(:user) { create :user, confirmed_at: nil, mobile_confirmation_code: 'LEFT' }
      let(:params) { attributes_for :user }

      it 'redirects to the confirm_user_path' do
        expect(response).to redirect_to confirm_user_path(user)
      end

      it 'renders an alert flash message' do
        expect(flash[:alert]).to eq 'Incorrect confirmation code'
      end
    end
  end

  describe 'GET #resend_confirmation' do
    before :each do
      log_in user
      get :resend_confirmation, id: user.id
    end

    context 'confirmed user' do
      let(:user) { create :user }

      it 'redirects to the users show page' do
        expect(response).to redirect_to user
      end

      it 'renders an notice flash message' do
        expect(flash[:notice]).to eq 'Your number is already confirmed'
      end
    end

    context 'user that got verification codes sent more than 9 times' do
      let(:user) { create :user, confirmed_at: nil, verification_codes_sent: 10 }

      it 'redirects to the users show page' do
        expect(response).to redirect_to user
      end

      it 'renders an alert flash message' do
        expect(flash[:alert]).to eq 'You have requested too many codes, please try again tomorrow'
      end
    end

    context 'user that is not confirmed and verification_codes_sent is less than 9' do
      let(:user) { create :user, confirmed_at: nil, verification_codes_sent: 0 }

      # TODO These three specs fail because of this ERROR VCR::Errors::UnhandledHTTPRequestError: due to Since service KEYS
      xit 'chnages the verification_codes_sent by 1' do
        expect(user.reload.verification_codes_sent).to eq 1
      end

      xit 'redirects to the confirm_user_path' do
        expect(response).to redirect_to confirm_user_path(user)
      end

      xit 'renders an notice flash message' do
        expect(flash[:notice]).to eq 'We sent it again! Please enter the confirmation code sent to your mobile phone'
      end
    end
  end

  describe 'GET #forgot_password' do
    before :each do
      get :forgot_password
    end

    it 'renders the forgot_password template' do
      expect(response).to render_template :forgot_password
    end
  end


  describe 'POST #send_reset_code' do
    # TODO I'll test this last, lots of specs to write here
  end

  describe 'GET #new_password' do
    let(:user) { create :user }

    before :each do
      get :new_password, id: user.id
    end

    it 'assigns the user' do
      expect(assigns(:user)).to eq user
    end

    it 'renders the new_password template' do
      expect(response).to render_template :new_password
    end
  end

  describe 'PATCH #reset_password' do
    # TODO I'll test this last, lots of specs to write here
  end

  describe 'GET #edit' do
    let(:user) { create :user }

    context 'when signed in' do
      before :each do
        log_in user
        get :edit, id: user.id
      end

      it 'assigns the user' do
        expect(assigns(:user)).to eq user
      end

      it 'renders the edit template' do
        expect(response).to render_template :edit
      end
    end

    context 'when not signed in' do
      before do
        get :edit, id: user.id
      end

       it 'cannot access edit' do
         expect(response).to redirect_to(new_session_url)
       end
    end

    context 'signed in with the wrong user' do
      let(:wrong_user) { create :user, mobile_number: '0791234567' }

      before do
        session[:user_id] = wrong_user.id
        get :edit, id: user
      end

      it 'cannot edit another user' do
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'PATCH #update' do
    let(:user) { create :user }

    context 'when signed in' do
      before :each do
        log_in user
        patch :update, id: user.id, user: params
      end

      context 'with valid params' do
        let(:params) { attributes_for :user, first_name: 'test_first_name', last_name: 'test_last_name' }

        it 'redirects to the users show page' do
          expect(response).to redirect_to user
        end

        it 'renders an notice flash message' do
          expect(flash[:notice]).not_to be nil
        end

        it 'updates the users attributes' do
          expect(user.first_name).to eq 'Usie'
          expect(user.last_name).to eq 'Userson'

          expect(user.reload.first_name).to eq 'test_first_name'
          expect(user.reload.last_name).to eq 'test_last_name'
        end
      end

      context 'with invalid params' do
        let(:params) { attributes_for :user, first_name: nil, last_name: nil }

        it 'renders the edit template' do
          expect(response).to render_template :edit
        end

        it 'renders an alert flash message' do
          expect(flash[:alert]).not_to be nil
        end

        it 'does not update the users attributes' do
          expect(user.reload.first_name).to eq 'Usie'
          expect(user.reload.last_name).to eq 'Userson'
        end
      end
    end

    context 'when not signed in' do
      let(:params) { attributes_for :user }

      before :each do
        patch :update, id: user, user: params
      end

      it 'cannot access update' do
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'signed in with the wrong user' do
      let(:params) { attributes_for :user }
      let(:wrong_user) { create :user, mobile_number: '0791234567' }

      before do
        session[:user_id] = wrong_user.id
        patch :update, id: user, user: params
      end

      it 'cannot edit another user' do
        expect(response).to redirect_to(root_url)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { create :user }
    let(:destroy_user) { delete :destroy, id: user.id }

    context 'when user signed in' do
      before :each do
        log_in user
      end

      it 'assigns the user' do
        destroy_user
        expect(assigns(:user)).to eq user
      end

      it 'deletes the user' do
        expect{ destroy_user }.to change(User, :count).by(-1)
      end

      it 'renders an alert flash message' do
        destroy_user
        expect(flash[:alert]).not_to be nil
      end
    end

    context 'when not signed in' do
      before :each do
        delete :destroy, id: user
      end

      it 'cannot access destroy' do
        expect(response).to redirect_to(new_session_url)
      end
    end

    context 'signed in with the wrong user' do
      let(:wrong_user) { create :user, mobile_number: '0791234567' }

      before do
        session[:user_id] = wrong_user.id
        patch :destroy, id: user
      end

      it 'cannot edit another user' do
        expect(response).to redirect_to(root_url)
      end
    end
  end
end
