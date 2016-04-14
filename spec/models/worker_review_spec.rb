require 'rails_helper'

describe 'given a user called workie and a worker review for workie' do
  before do
    @workie = Worker.create first_name: 'Workie', last_name: 'Workieson', password: 'bl@h1112', mobile_number: '0717893456'
    @jim = User.create first_name: 'Jim', last_name: 'Hendrics', password: 'bl@h1112', mobile_number: '0796546543'
    @work_reference = WorkReference.create work: 'IT', worker: @workie, employer_user: @jim
  end

  describe 'when i delete the user workie' do
    it 'then the review should no longer exist' do
      work_references_count= WorkReference.all.count
      @workie.destroy
      expect work_references_count!= WorkReference.all.count
      error = "Couldn't find WorkReference with 'id'=#{@work_reference.id}"
      expect { WorkReference.find(@work_reference.id) }.to raise_error error
    end
  end
end
