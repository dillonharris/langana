class ConfirmationToken
  def self.generate(user)
    token = random_token
    user.mobile_confirmation_token = token
    SinchSms.send(ENV.fetch('SINCH_KEY'), ENV["SINCH_SECRET"], "Your code is #{token}", user.mobile_number)
    user.mobile_confirmation_sent_at = Time.now
    user.confirmation_attempts = 0
    user.save
  end

  def self.random_token(size = 4)
    chars = (('a'..'z').to_a + ('2'..'9').to_a) - %w(i o l)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end
end
