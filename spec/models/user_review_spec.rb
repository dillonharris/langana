require 'rails_helper'

describe 'given a user called pete and a review for pete' do
  before do
    @pete = User.create first_name: 'Pete', last_name: 'Peterson', password: 'bl@h1112', mobile_number: '0717893456'
    @jim = User.create first_name: 'Jim', last_name: 'Hendrics', password: 'bl@h1112', mobile_number: '0796546543'
    @review = Review.create work: 'IT', reviewed: @pete, reference: @jim
  end

  describe 'when i delete the user pete' do
    it 'then the review should no longer exist' do
      reviews_count = Review.all.count
      @pete.destroy
      expect reviews_count != Review.all.count
      error = "Couldn't find Review with 'id'=#{@review.id}"
      expect { Review.find(@review.id) }.to raise_error error
    end
  end
end
