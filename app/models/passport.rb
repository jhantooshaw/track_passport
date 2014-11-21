class Passport < ActiveRecord::Base
  CHARS = %w{1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z} 
  SIZE = 8
  
  STATUS = [
    ["Ready To Start", "ready_to_start"],
    ["In Process", "in_process"],
    ["Delivered", "delivered"]
  ]
  
  default_scope {order("created_at desc")}
  
 
  
  before_create :ensure_unique_number
  
  def self.fullname
    
  end
  
  private
  def ensure_unique_number
    found = false
    begin
      @number = (0...SIZE).map{CHARS.to_a[rand(CHARS.size)] }.join
      found = Passport.find_by_unique_number(@number).present?
    end until found == false
    self.unique_number = @number
  end
end
