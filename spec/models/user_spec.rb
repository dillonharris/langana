require 'rails_helper'

describe "A user" do

  it "requires a first name" do
    user = User.new(first_name: "")

    expect(user.valid?).to eq(false)
    expect(user.errors[:first_name].any?).to eq(true)
  end

  it "requires a last name" do
    user = User.new(last_name: "")

    expect(user.valid?).to eq(false)
    expect(user.errors[:last_name].any?).to eq(true)
  end

  it "requires a mobile number" do
    user = User.new(mobile_number: "")

    user.valid? # populates errors

    expect(user.errors[:mobile_number].any?).to eq(true)
  end

  it "accepts properly formatted mobile numbers" do
    numbers = %w[+27791231234]
    numbers.each do |number|
      user = User.new(mobile_number: number)

      user.valid?

      expect(user.errors[:mobile_number].any?).to eq(false)
    end
  end

  xit "accepts properly formatted but weirdly entered mobile numbers" do
    numbers = ["+27791231234", "0791231234", "079 123 1234", "0 7 9 1 2 3 1 2 3 4"]
    numbers.each do |number|
      user = User.new(number: number)

      user.valid?

      expect(user.errors[:number].any?).to eq(false)
    end
  end

  xit "rejects improperly formatted mobile number" do
    emails = %w[@ user@ @example.com]
    emails.each do |email|
      user = User.new(email: email)

      user.valid?

      expect(user.errors[:email].any?).to eq(true)
    end
  end

  it "requires a unique mobile number" do
    user1 = User.create!(user_attributes)

    user2 = User.new(mobile_number: user1.mobile_number)
    user2.valid?
    expect(user2.errors[:mobile_number].first).to eq("has already been taken")
  end

  it "is valid with example attributes" do
    user = User.new(user_attributes)

    expect(user.valid?).to eq(true)
  end

  it "requires a password" do
    user = User.new(password: "")

    user.valid?

    expect(user.errors[:password].any?).to eq(true)
  end

  it "requires a password confirmation when a password is present" do
    user = User.new(password: "secret", password_confirmation: "")

    user.valid?

    expect(user.errors[:password_confirmation].any?).to eq(true)
  end

  it "requires the password to match the password confirmation" do
    user = User.new(password: "secret", password_confirmation: "nomatch")

    user.valid?

    expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
  end

  it "requires a password and matching password confirmation when creating" do
    user = User.create!(user_attributes(password: "secret", password_confirmation: "secret"))

    expect(user.valid?).to eq(true)
  end

  it "does not require a password when updating" do
    user = User.create!(user_attributes)

    user.password = ""

    expect(user.valid?).to eq(true)
  end

  it "automatically encrypts the password into the password_digest attribute" do
    user = User.new(password: "secret")

    expect(user.password_digest.present?).to eq(true)
  end
end

describe "authenticate" do
  before do
    @user = User.create!(user_attributes)
  end

  it "returns non-true value if the mobile number does not match" do
    expect(User.authenticate("666", @user.password)).not_to eq(true)
  end

  it "returns non-true value if the password does not match" do
    expect(User.authenticate(@user.mobile_number, "nomatch")).not_to eq(true)
  end

  it "returns the user if the email and password match" do
    expect(User.authenticate(@user.mobile_number, @user.password)).to eq(@user)
  end
end
