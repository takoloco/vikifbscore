class LikesController < ApplicationController
  def get_likes(p_url)
    require 'net/http'
    url = URI.parse(p_url)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    JSON(res.body)["likes"]
  end
end
