module ApplicationHelper
  def self.format_mobile(number)
    if number && number.empty? == false
      if number[0] == '0' && number.length == 10
        number = '+27' + number.reverse.chop.reverse
      end
    end
    number
  end
end
