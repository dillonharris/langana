require 'rails_helper'

describe "Creating a new user" do
  it "saves a worker user and shows the user's profile page" do
    visit root_url

    click_link 'Sign Up'

    expect(current_path).to eq(choose_role_path)
    click_link 'I am looking for work'

    expect(current_path).to eq(signup_worker_path)
    fill_in "user_first_name",  with: "Workie"
    fill_in "user_last_name", with: "Workerson"
    fill_in "user_mobile_number", with: "0792857438"
    fill_in "user_password", with: "secret"
    fill_in "user_password_confirmation", with: "secret"
    select "Building", from: "Service"
    fill_in "Home language", with: "English"
    fill_in "Id or passport number", with: "0305684795"
    fill_in "Country of citizenship", with: "South Africa"
    fill_in "City", with: "Cape Town"

    click_button 'Create Account'

    expect(current_path).to eq(confirm_user_path(User.last))
    expect(page).to have_text('Thanks for signing up!')
    expect(User.last.confirmed_at).to be_nil
    expect(User.last.first_name).to eq('worker')
    expect(User.last.last_name).to eq('worker')
    expect(User.last.mobile_number).to eq('worker')
    expect(User.last.service).to eq('worker')
    expect(User.last.home_language).to eq('worker')
    expect(User.last.second_language).to eq('worker')
    expect(User.last.third_language).to eq('worker')
    expect(User.last.id_or_passport_number).to eq('worker')
    expect(User.last.country_of_citizenship).to eq('worker')
    expect(User.last.work_permit_status).to eq('worker')
    expect(User.last.street_address).to eq('worker')
    expect(User.last.unit).to eq('worker')
    expect(User.last.suburb).to eq('worker')
    expect(User.last.city).to eq('worker')
    expect(User.last.province).to eq('worker')
    expect(User.last.postal_code).to eq('worker')
    expect(User.last.country).to eq('worker')
    expect(User.last.drivers_license).to eq('worker')
    expect(User.last.role).to eq('worker')
    visit user_path((User.last))
    expect(page).to have_text('Workie')
    expect(page).to have_text('Building')
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  it "saves an employer user and shows the user's profile page" do
    visit choose_role_path

    click_link 'I am wanting to hire'

    expect(current_path).to eq(signup_employer_path)

#    choose 'user_role_employer'
    fill_in "user_first_name",  with: "Emplie"
    fill_in "user_last_name", with: "Employerson"
    fill_in "user_mobile_number", with: "0792857439"
    fill_in "user_password", with: "secret"
    fill_in "user_password_confirmation", with: "secret"

    click_button 'Create Account'

    expect(current_path).to eq(confirm_user_path(User.last))
    expect(page).to have_text('Thanks for signing up!')
    expect(User.last.confirmed_at).to be_nil
    expect(User.last.role).to eq('employer')
    visit user_path((User.last))
    expect(page).to have_text('Emplie')
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end

  it "does not save the user if it's invalid" do
    visit signup_employer_path

    expect {
      click_button 'Create Account'
    }.not_to change(User, :count)

    expect(page).to have_text('error')
  end
end

