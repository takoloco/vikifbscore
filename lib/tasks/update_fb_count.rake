require "#{File.dirname(__FILE__)}/../../config/environment.rb"

require 'Company'
require 'Like'

class UpdateFbCount
  def run_update
    Company.transaction do
      @companies = Company.find(:all, :joins => :like, :readonly => false)

      begin
        @companies.each do |company|
          count = Like.get_likes('http://graph.facebook.com/' + company.facebook_id)
          company.like.Count = count
          company.save
          puts 'Count for ' + company.name.to_s + ' (facebook ID: ' + company.facebook_id.to_s + ') updated with ' + count.to_s
        end
      rescue ActiveRecord::StatementInvalid
      end
    end
  end
end

namespace:daily do
  desc "Update FB Like Counts daily"
  task:UpdateFbCount do
    batch = UpdateFbCount.new()
    batch.run_update
  end
end
