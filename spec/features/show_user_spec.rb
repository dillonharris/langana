require 'rails_helper'

describe 'Viewing an individual employer' do
  let (:employer) { FactoryGirl.create(:user) }

  it "shows the employer's details" do
    sign_in(employer)
    visit user_url(employer)
    expect(page).to have_text(employer.first_name)
    expect(page).to have_text(employer.email)
  end
end
