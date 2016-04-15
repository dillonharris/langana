require 'rails_helper'

describe 'Viewing an individual worker' do
  it 'goes to workers show page from root page' do
    worker = FactoryGirl.create(:worker)
    visit '/'

    sign_in(worker)
    click_link(worker.first_name)
    expect(page).to have_text(worker.first_name)
    expect(page).to have_text(worker.last_name)
    expect(page).to have_text(worker.home_language)
    expect(page).to have_text(worker.mobile_number)
  end

  # it "shows the worker's details" do
  #   worker = FactoryGirl.create(:worker)
  #   sign_in(worker)
  #   visit worker_url(worker)
  #   expect(page).to have_text(worker.first_name)
  #   expect(page).to have_text(worker.email)
  # end

  # it "shows a worker's details to confirmed potential employers" do
  #   worker = FactoryGirl.create(:user, role: "worker")
  #   employer = FactoryGirl.create(:user, role: "employer")
  #   sign_in(employer)
  #   visit user_url(worker)
  #   expect(page).to have_text(worker.first_name)
  #   expect(page).to have_text(worker.email)
  # end

  # it "redirect unconfirmed employers to their confirmation page" do
  #   worker = FactoryGirl.create(:user, role: "worker")
  #   employer = FactoryGirl.create(:user, role: "employer", confirmed_at: nil)
  #   sign_in(employer)
  #   visit user_url(worker)
  #   expect(current_path).to eq(confirm_user_path(employer))
  # end
end
