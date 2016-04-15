require 'rails_helper'

describe 'Viewing an individual user' do
  let (:worker) { FactoryGirl.create(:worker) }

  it "shows the user's details" do
    user = FactoryGirl.create(:user)
    sign_in(user)
    visit user_url(user)
    expect(page).to have_text(user.first_name)
    expect(page).to have_text(user.email)
  end

  it "shows a worker's details to confirmed potential employers" do
    employer = FactoryGirl.create(:user, role: 'employer')
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
