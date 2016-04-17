require 'rails_helper'

describe 'Viewing an individual worker' do
  let (:worker) { FactoryGirl.create(:worker) }
  let (:employer) { FactoryGirl.create(:user) }

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

  it "shows a worker's details to confirmed potential employers" do
    sign_in(employer)
    visit worker_url(worker)
    expect(page).to have_text(worker.first_name)
    expect(page).to have_text(worker.email)
  end

  it 'redirect unconfirmed employers to their confirmation page' do
    employer = FactoryGirl.create(:user, role: 'employer', confirmed_at: nil)
    sign_in(employer)
    visit worker_url(worker)
    expect(current_path).to eq(confirm_user_path(employer))
  end
end
