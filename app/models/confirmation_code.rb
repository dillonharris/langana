class ConfirmationCode
  def self.generate(user)
    code = random_code
    user.mobile_confirmation_code = code
    SinchSms.send(ENV.fetch('SINCH_KEY'), ENV["SINCH_SECRET"], "Thanks for using Langana. Your code is #{code}", user.mobile_number)
    user.mobile_confirmation_sent_at = Time.now
    user.confirmation_attempts = 0
    user.save
  end

  def self.random_code(size = 4)
    chars = (('a'..'z').to_a + ('2'..'9').to_a) - %w(i o l)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end
end
