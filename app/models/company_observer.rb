class CompanyObserver < ActiveRecord::Observer
  def after_save(model)
    url = URI.parse('http://graph.facebook.com/' + model.facebook_id.downcase)
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    count = JSON(res.body)["likes"]
    @Like = model.create_like(:Count => count)
  end
end
