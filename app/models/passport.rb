class Passport < ActiveRecord::Base
  has_many    :visas,     dependent: :destroy
  
  default_scope {order("created_at desc")}
 
  
  
  
  def self.fullname
    
  end
  
  
end
