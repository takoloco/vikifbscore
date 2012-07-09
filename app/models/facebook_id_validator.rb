require 'json'
class FacebookIdValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if value.to_s.strip.length == 0
    url = URI.parse('http://graph.facebook.com/' + value.downcase)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    unless res.body.to_s.downcase != 'false' && JSON(res.body).keys.include?("likes")
      record.errors[attribute] << "Invalid Facebook ID. Page does not exist."
    end 
  end
end
