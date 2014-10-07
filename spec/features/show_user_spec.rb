require 'rails_helper'

describe "Viewing an individual user" do
  it "shows the user's details" do
    
    user = User.create(user_attributes)

    visit "http://example.com/users/#{user.id}"

    expect(page).to have_text(user.name)
    expect(page).to have_text(user.email)
  end
end