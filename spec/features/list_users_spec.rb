require 'rails_helper'

describe "Viewing the list of users" do
  
  it "shows the users" do
    visit 'http://example.com/users'

    expect(page).to have_text("3 Users")
  end
  
end


