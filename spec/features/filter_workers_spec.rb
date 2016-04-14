describe "Filtering workers" do

  it "shows building workers" do
    builder = FactoryGirl.create(:worker,
      first_name: "Dillon",
      last_name: "Example User",
      mobile_number: "+27720000002",
      password: "secret",
      password_confirmation: "secret",
      confirmed_at: Time.now,
      service: 'Building'
    )
    gardener = FactoryGirl.create(:worker,
      first_name: "De Wet",
      last_name: "Example User",
      mobile_number: "+27720000000",
      password: "secret",
      password_confirmation: "secret",
      confirmed_at: Time.now,
      service: 'gardening'
    )

    visit workers_url

    click_link "Building"

    expect(current_path).to eq("/workers/filter/building")
    expect(page).to have_text(builder.first_name)
    expect(page).not_to have_text(gardener.first_name)
  end
end

