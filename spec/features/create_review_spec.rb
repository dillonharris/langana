require 'rails_helper'

describe "Creating a new review" do
  it "saves the review and shows the review on the user's detail page" do
    user1 = User.create!(user_attributes)
    user2 = User.create!({
                        name: "Jeremy Ramos",
                        email: "other@example.com",
                        password: "secret",
                        password_confirmation: "secret"
                      })


    sign_in(user1)

    visit user_path(user2)

    click_link 'Give Reference'

    expect(current_path).to eq(new_user_review_path(user2))

    fill_in "What work did #{user2.name} do for you?", with: "#{user2.name} fixed my computer"

    fill_in "Comment", with: "They installed more ram, reinstalled my OS and restored all of my data. I could not be happier"

    click_button 'Post Reference'

    expect(current_path).to eq(user_path(user2))

    expect(page).to have_text("Thanks for your review!")
    expect(page).to have_text("They installed more ram")
  end

  xit "does not save the review if it's invalid" do
    user1 = User.create!(user_attributes)
    user2 = User.create!({
                        name: "Other Person",
                        email: "other@example.com",
                        password: "secret",
                        password_confirmation: "secret"
                      })


    sign_in(user1)

    visit user_path(user2)

    click_link 'Give Reference'

    expect {
      click_button 'Post Reference'
    }.not_to change(Reference, :count)

    expect(page).to have_text('error')
  end
end