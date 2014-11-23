class Passport < ActiveRecord::Base
  SEARCH_BY = [
    ["Email Address", "email"],
    ["Mobile Number", "mobile"],
    ["Passport Number", "passport"]
  ]
  
  has_many    :visas,     dependent: :destroy  
  default_scope {order("created_at desc")}
 
  
  
  
  def self.fullname
    
  end
  
  def already_visa
    visas.where("status != ?", 'delivered').first
  end
  
  
end
