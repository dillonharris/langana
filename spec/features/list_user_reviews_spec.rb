require 'rails_helper'

describe "Given a user called Kenwin with a reference from another user called De Wet" do
  before do
    @dewet = FactoryGirl.create(:user, first_name: "De Wet", mobile_number: "0792951234")
    @kenwin = FactoryGirl.create(:user, first_name: "Kenwin",   mobile_number: "0729251234")
    @review = WorkReference.create work: 'IT', comment: 'The best IT work ever!!!', worker_user: @kenwin, employer_user: @dewet
  end

  describe 'when users gives reviews to a user it lists the reviews on their profile page' do

    it "lists reviews" do

      sign_in(@dewet)

      visit user_url(@kenwin)

      expect(page).to have_text(@review.work)
      expect(page).to have_text(@review.comment)
    end
  end
end
