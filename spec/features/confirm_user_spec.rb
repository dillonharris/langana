require 'rails_helper'

describe "Confirming a mobile number" do

  it "confirms with the correct mobile confirmation code" do
    user = FactoryGirl.create(:user, mobile_confirmation_code: "abcde", confirmed_at: nil)
    expect(user.confirmed_at).to be_nil
    sign_in(user)
    visit confirm_user_path(user)
    fill_in "Mobile confirmation code", with: "abcde"
    click_button "Confirm Mobile Number"
    expect(page).to have_text("Thanks for confirming your mobile number!")
    user.reload
    expect(user.confirmed_at).not_to be_nil
  end

  it "does not confirm with the incorrect mobile confirmation code" do
    user = FactoryGirl.create(:user, mobile_confirmation_code: "abcde", confirmed_at: nil)
    expect(user.confirmed_at).to be_nil
    sign_in(user)
    visit confirm_user_path(user)
    fill_in "Mobile confirmation code", with: ""
    click_button "Confirm Mobile Number"
    expect(page).to have_text("Incorrect confirmation code")
    expect(user.confirmed_at).to be_nil
  end

  it "resends verification code when the user requests it", :vcr do
    user = FactoryGirl.create(:user, mobile_confirmation_code: "abcde", confirmed_at: nil)
    expect(user.confirmed_at).to be_nil
    sign_in(user)
    visit confirm_user_path(user)
    click_link "Resend verification"
    expect(page).to have_text("We sent it again")
  end

  it "show a button to confrim in the header if user is not confirmed" do
    user = FactoryGirl.create(:user, mobile_confirmation_code: "abcde", confirmed_at: nil)
    sign_in(user)
    expect(page).to have_text("Confirm phone number")
  end
end
