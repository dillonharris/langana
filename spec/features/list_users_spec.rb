require 'rails_helper'

describe "Viewing the list of users" do

  it "shows the users" do
    user1 = FactoryGirl.create(:user, first_name: "Larry", mobile_number: "0791237894")
    user2 = FactoryGirl.create(:user, first_name: "Moe",   mobile_number: "0799999999")
    user3 = FactoryGirl.create(:user, first_name: "Curly", mobile_number: "0791239632")

    visit users_url

    expect(page).to have_link(user1.first_name)
    expect(page).to have_link(user2.first_name)
    expect(page).to have_link(user3.first_name)
  end

end


