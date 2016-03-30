require 'rails_helper'

describe "Creating a new worker" do
  it "saves a worker and shows the worker's profile page", :vcr do
    visit root_url

    click_link 'Sign Up'

    expect(current_path).to eq(choose_role_path)
    click_link 'I am looking for work'

    expect(current_path).to eq(signup_worker_path)
    fill_in "worker_first_name",  with: "Workie"
    fill_in "worker_last_name", with: "Workerson"
    fill_in "worker_mobile_number", with: "0792857438"
    fill_in "worker_password", with: "secret"
    fill_in "worker_password_confirmation", with: "secret"
    select "Building", from: "Service"
    fill_in "Home language", with: "English"
    fill_in "Second language", with: "Afrikaans"
    fill_in "Third language", with: "Xhosa"
    fill_in "Id or passport number", with: "0305684795"
    fill_in "Country of citizenship", with: "South Africa"
    select "Cape Town", from: "City"
    select "South African Citizen", from: "Work permit status"

    click_button 'Create Account'

    expect(current_path).to eq(confirm_worker_path(Worker.last))
    expect(page).to have_text('Thanks for signing up!')
    expect(Worker.last.confirmed_at).to be_nil
    expect(Worker.last.first_name).to eq('Workie')
    expect(Worker.last.last_name).to eq('Workerson')
    expect(Worker.last.mobile_number).to eq('+27792857438')
    expect(Worker.last.service).to eq('Building')
    expect(Worker.last.home_language).to eq('English')
    expect(Worker.last.second_language).to eq('Afrikaans')
    expect(Worker.last.third_language).to eq('Xhosa')
    expect(Worker.last.id_or_passport_number).to eq('0305684795')
    expect(Worker.last.country_of_citizenship).to eq('South Africa')
    expect(Worker.last.work_permit_status).to eq('South African Citizen')
    # expect(Worker.last.street_address).to eq('worker')
    # expect(Worker.last.unit).to eq('worker')
    # expect(Worker.last.suburb).to eq('worker')
    # expect(Worker.last.city).to eq('worker')
    # expect(Worker.last.province).to eq('worker')
    # expect(Worker.last.postal_code).to eq('worker')
    # expect(Worker.last.country).to eq('worker')
    # expect(Worker.last.drivers_license).to eq('worker')
    # expect(Worker.last.role).to eq('worker')
    visit worker_path((Worker.last))
    expect(page).to have_text('Workie')
    expect(page).to have_text('Building')
    expect(page).not_to have_link('Sign In')
    expect(page).not_to have_link('Sign Up')
  end
end