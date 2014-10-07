require 'rails_helper'

def user_attributes(overrides = {})
  {
    name: "Example User",
    email: "user@example.com",
    password: "secret",
    password_confirmation: "secret"
  }.merge(overrides)
end

describe "Navigating users" do
  it "allows navigation from the profile page to the listing page" do
    user = User.create(user_attributes)

    visit user_url(user)

    click_link "All Users"

    expect(current_path).to eq(users_path)
  end
end