class Company < ActiveRecord::Base
  attr_accessible :description, :facebook_id, :name, :url
 
  validates :name,  :presence => true, :length => { :in => 1..255 }
  validates :url,   :presence => true,
                    :length => { :in => 8..255 },
                    :format =>  { :with => /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix,
                                  :message => "Invalid URL format" }
  validates :facebook_id,  :presence => true, :length => { :in => 1..255 }, :uniqueness => true,  :uniqueness => { :case_sensitive => false }, :facebook_id => true
  validates :description,  :presence => true

  has_one :like, :dependent => :destroy
  accepts_nested_attributes_for :like
end
