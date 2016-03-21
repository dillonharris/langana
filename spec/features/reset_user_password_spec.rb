require 'rails_helper'

describe "Resetting a user's password" do
  it "has a link to it" do
    user = FactoryGirl.create(:user, mobile_number: "+27795555555")
    visit new_session_path
    click_link("Forgot your password?")
    expect(current_path).to eq(forgot_password_path)
    expect(page).to have_text("Don't worry")
  end

  it "takes a mobile number & sends a reset code if it's found in the databse", :vcr do
    allow(ConfirmationCode).to receive(:random_code).and_return("abcde")
    user = FactoryGirl.create(:user, mobile_number: "+27795555555", mobile_confirmation_code: "abcde")
    visit forgot_password_path
    fill_in "Mobile number", with: user.mobile_number
    click_button "Reset password"
    expect(current_path).to eq(new_password_user_path(user))
    fill_in "Mobile confirmation code", with: "abcde"
    fill_in "user_password", with: "sdfsdf"
    fill_in "user_password_confirmation", with: "sdfsdf"
    click_button "Change Password"
    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Password reset successful")
  end

  it "takes a mobile number & notifies the user if it's not found in the databse" do
    visit forgot_password_path
    fill_in "Mobile number", with: "0797777777"
    click_button "Reset password"
    expect(current_path).to eq(forgot_password_path)
    expect(page).to have_text("No account with that phone number")
  end

  it "only accepts the reset code one time", :vcr do
    user = FactoryGirl.create(:user, mobile_number: "+27795555555", mobile_confirmation_code: "abcde")
    visit forgot_password_path
    fill_in "Mobile number", with: user.mobile_number
    click_button "Reset password"
    expect(current_path).to eq(new_password_user_path(user))
    fill_in "Mobile confirmation code", with: "abcde"
    fill_in "user_password", with: "sdfsdf"
    fill_in "user_password_confirmation", with: "sdfsdf"
    click_button "Change Password"
    visit new_password_user_path(user)
    fill_in "Mobile confirmation code", with: "abcde"
    fill_in "user_password", with: "sdfsdf"
    fill_in "user_password_confirmation", with: "sdfsdf"
    click_button "Change Password"
    expect(page).to have_text("Incorrect confirmation code")
    # This spec passed before the feature was implemented, I need help
  end
end
