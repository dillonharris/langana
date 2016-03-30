require 'rails_helper'

describe "Creating a new user" do
  it "saves an employer user and shows the user's profile page", :vcr do
    visit choose_role_path

    click_link 'I am wanting to hire'

    expect(current_path).to eq(signup_employer_path)

#    choose 'user_role_employer'
    fill_in "user_first_name",  with: "Emplie"
    fill_in "user_last_name", with: "Employerson"
    fill_in "user_mobile_number", with: "0792857439"
    fill_in "user_password", with: "secret"
    fill_in "user_password_confirmation", with: "secret"

    click_button 'Create Account'

    expect(current_path).to eq(confirm_user_path(User.last))
    expect(page).to have_text('Thanks for signing up!')
    expect(User.last.confirmed_at).to be_nil
    expect(User.last.role).to eq('employer')
    visit user_path((User.last))
    expect(page).to have_text('Emplie')
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  it "does not save the user if it's invalid" do
    visit signup_employer_path

    expect {
      click_button 'Create Account'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
  end
end

