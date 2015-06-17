require 'rails_helper'

describe "Confirming a mobile number" do

  it "confirms with the correct mobile confirmation token" do
    user = FactoryGirl.create(:user, mobile_confirmation_token: "abcde")

    sign_in(user)
    visit confirm_user_path(user)

    fill_in "Mobile confirmation token", with: "abcde"

    click_button "Confirm Mobile Number"

    expect(page).to have_text("Thanks for confirming your mobile number!")
  end

  it "does not confirm with the incorrect mobile confirmation token" do
    user = FactoryGirl.create(:user, mobile_confirmation_token: "abcde")

    sign_in(user)
    visit confirm_user_path(user)

    fill_in "Mobile confirmation token", with: ""

    click_button "Confirm Mobile Number"

    expect(page).to have_text("Incorrect confirmation token")
  end
end
