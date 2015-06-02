require 'rails_helper'
require 'support/attributes'

describe "Viewing the list of users" do

  it "shows the users" do
    user1 = User.create!(user_attributes(name: "Larry", email: "0791237894"))
    user2 = User.create!(user_attributes(name: "Moe",   email: "0799999999"))
    user3 = User.create!(user_attributes(name: "Curly", email: "0791239632"))

    visit users_url

    expect(page).to have_link(user1.name)
    expect(page).to have_link(user2.name)
    expect(page).to have_link(user3.name)
  end

end


