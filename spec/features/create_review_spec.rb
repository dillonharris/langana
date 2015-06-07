require 'rails_helper'
require 'support/authentication'

describe "Creating a new review" do
  it "saves the review and shows the review on the user's detail page" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user,
                        first_name: "Jeremy",
                        last_name: "Ramos",
                        mobile_number: "0723423458",
                        password: "secret",
                        password_confirmation: "secret"
                      )


    sign_in(user1)

    visit user_path(user2)

    click_link 'Give Reference'

    expect(current_path).to eq(new_user_review_path(user2))

    fill_in "What work did #{user2.first_name} do for you?", with: "#{user2.first_name} fixed my computer"

    fill_in "Comment", with: "They installed more ram, reinstalled my OS and restored all of my data. I could not be happier"

    click_button 'Post Reference'

    expect(current_path).to eq(user_path(user2))

    expect(page).to have_text("Thanks for giving a reference!")
    expect(page).to have_text("They installed more ram")
  end

  it "does not save the review if it's invalid" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user,
                        first_name: "Other",
                        last_name: "Person",
                        mobile_number: "0723423459",
                        password: "secret",
                        password_confirmation: "secret"
                      )


    sign_in(user1)

    visit user_path(user2)

    click_link 'Give Reference'

    expect {
      click_button 'Post Reference'
    }.not_to change(Review, :count)

    expect(page).to have_text('error')
  end
end
