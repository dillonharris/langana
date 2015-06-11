require 'rails_helper'

describe "Creating a new user" do
  it "saves the user and shows the user's profile page" do
    visit root_url

    click_link 'Sign Up'

    expect(current_path).to eq(signup_path)

    fill_in "user_first_name",  with: "Usie"
    fill_in "user_last_name", with: "Userson"
    fill_in "user_mobile_number", with: "0792857438"
    fill_in "user_password", with: "secret"
    fill_in "user_password_confirmation", with: "secret"

    click_button 'Create Account'

    expect(current_path).to eq(confirm_user_path(User.last))

    expect(User.last.confirmed_at).to be_nil
    expect(page).to have_text('Usie')
    expect(page).to have_text('Thanks for signing up!')
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  it "does not save the user if it's invalid" do
    visit signup_url

    expect {
      click_button 'Create Account'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
  end
end

