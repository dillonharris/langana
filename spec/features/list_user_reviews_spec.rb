require 'rails_helper'
require 'support/attributes'

describe "Given a user called Kenwin with a reference from another user called De Wet" do
  before do
    @dewet = User.create!(user_attributes(name: "De Wet", email: "dewet@example.com"))
    @kenwin = User.create!(user_attributes(name: "Kenwin",   email: "kenwin@example.com"))
    @review = Review.create work: 'IT', comment: 'The best IT work ever!!!', reviewed: @kenwin, reference: @dewet
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