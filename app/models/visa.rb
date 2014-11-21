class Visa < ActiveRecord::Base
  CHARS = %w{1 2 3 4 5 6 7 8 9 a b c d e f g h i j k l m n o p q r s t u v w x y z A B C D E F G H I J K L M N O P Q R S T U V W X Y Z} 
  SIZE = 8  
  STATUS = [
    ["Under Process", "under_process"],
    ["Gratnted", "granted"],
    ["Rejected", "rejected"],
    ["Delivered", "delivered"]
  ]
  
  VISA_TYPES = [ 
    ["Tourist", "tourist"],
    ["Transit", "transit"]    
  ]
  
  belongs_to  :passport
  
  before_create :ensure_unique_number
  
  private
  def ensure_unique_number
    found = false
    begin
      @number = (0...SIZE).map{CHARS.to_a[rand(CHARS.size)] }.join
      found = Visa.find_by_unique_number(@number).present?
    end until found == false
    self.unique_number = @number
  end
  
end
