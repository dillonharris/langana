require 'rails_helper'

describe 'given a user called pete and a review for pete' do
  before do
    @pete = User.create name: 'Pete', password: 'bl@h1112', email: 'some@email.com'
    @jim = User.create name: 'Jim', password: 'bl@h1112', email: 'some@email.com'
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