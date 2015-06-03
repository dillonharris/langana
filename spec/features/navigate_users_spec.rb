require 'rails_helper'

describe "Navigating users" do
  it "allows navigation from the profile page to the listing page" do
    user = User.create(user_attributes)

    visit user_url(user)

    click_link "All Users"

    expect(current_path).to eq(users_path)
  end

  it "allows navigation from the listing page to the profile page" do
    user = User.create(user_attributes)

    sign_in(user)

    visit users_url

    first(:link, user.first_name).click

    expect(current_path).to eq(user_path(user))
  end

end
