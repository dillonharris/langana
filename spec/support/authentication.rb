def sign_in(user)
  visit new_session_url
  fill_in "Mobile number", with: user.mobile_number
  fill_in "Password", with: user.password
  click_button "Sign In"
end
