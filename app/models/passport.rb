class Passport < ActiveRecord::Base
  has_many    :visas
  
  default_scope {order("created_at desc")}
 
  
  
  
  def self.fullname
    
  end
  
  
end
