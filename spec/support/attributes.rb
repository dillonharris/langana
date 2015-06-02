def user_attributes(overrides = {})
  {
    first_name: "Usie",
    last_name: "Userson",
    mobile_number: "0791231234",
    password: "secret",
    password_confirmation: "secret"
  }.merge(overrides)
end
