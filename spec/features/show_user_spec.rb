require 'rails_helper'

def user_attributes(overrides = {})
  {
    name: "Example User",
    email: "user@example.com",
    password: "secret",
    password_confirmation: "secret"
  }.merge(overrides)
end

describe "Viewing an individual user" do
  it "shows the user's details" do
    user = User.create(name: "De Wet",
                        email: "dewet@example.com",
                        password: "secret",
                        password_confirmation: "secret")

    visit "http://example.com/users/#{user.id}"

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end
end