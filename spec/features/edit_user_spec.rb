require 'rails_helper'

describe "Editing a user" do
  it "updates an employer user and shows the user's updated details" do
    user = FactoryGirl.create(:user, role: 'employer')
    sign_in(user)
    visit user_url(user)
    click_link 'Edit Account'
    expect(current_path).to eq(edit_employer_user_path(user))
    expect(find_field('user_first_name').value).to eq(user.first_name)
    fill_in "First name", with: "Updated User First name"
    click_button "Update Account"
    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Updated User First name")
    expect(page).to have_text('Account successfully updated!')
  end

  it "updates a worker user and shows the user's updated details" do
    user = FactoryGirl.create(:user,
      role: 'worker',
      home_language: 'English'
    )
    sign_in(user)
    visit user_url(user)
    click_link 'Edit Account'
    expect(current_path).to eq(edit_worker_user_path(user))
    expect(find_field('user_home_language').value).to eq(user.home_language)
    fill_in "Home language", with: "Updated User Home Language"
    click_button "Update Account"
    expect(current_path).to eq(user_path(user))
    expect(page).to have_text("Updated User Home Language")
    expect(page).to have_text('Account successfully updated!')
  end

  it 'changes role' do
    user = FactoryGirl.create(:user, role: 'worker')
    sign_in(user)
    visit edit_user_path(user)
    choose 'user_role_employer'
#    fill_in 'Current password', :with => user.password
    click_button 'Update'
    expect(current_path).to eq(user_path(user))
    expect(page).to have_text('Account successfully updated!')
    expect(page).to have_content('Employer')
  end

  it "does not update the user if it's invalid" do
    user = FactoryGirl.create(:user, role: 'worker')
    sign_in(user)
    visit edit_worker_user_url(user)
    fill_in 'user_first_name', with: " "
    click_button "Update Account"
    expect(page).to have_text('error')
  end
end

