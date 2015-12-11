describe "Filtering users" do

	it "shows building users" do 
		builder = User.create!({
    first_name: "Dillon",
    last_name: "Example User",
    mobile_number: "+27720000002",
    password: "secret",
    password_confirmation: "secret",
    confirmed_at: Time.now,
    role: 'worker',
    service: 'Building'
  })
  	gardener = User.create!({
    first_name: "De Wet",
    last_name: "Example User",
    mobile_number: "+27720000000",
    password: "secret",
    password_confirmation: "secret",
    confirmed_at: Time.now,
    role: 'worker',
    service: 'gardening'
  })

		visit users_url

		click_link "Building"

		expect(current_path).to eq("/users/filter/building")
		expect(page).to have_text(builder.first_name)
		expect(page).not_to have_text(gardener.first_name)
	end

end