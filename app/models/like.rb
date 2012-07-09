class Like < ActiveRecord::Base
  belongs_to :company
  attr_accessible :Count

  def self.get_likes(p_url)
    require 'net/http'
    url = URI.parse(p_url)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    return false if res.body.to_s.downcase == 'false' || !JSON(res.body).keys.include?("likes")
    JSON(res.body)["likes"]
  end
end
