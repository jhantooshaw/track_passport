class VisasController < ApplicationController 
  
  def track
    @unique_number = params[:token] if params[:token]
    if request.post?
      begin
        if params[:id].present?
          @passport = Passport.find(params[:id])
          @visa = @passport.visas.where(unique_number: params[:unique_number], mobile: params[:mobile])
        else
          @visa = Visa.joins(:passport).where("visas.unique_number=? and passports.mobile=?", params[:unique_number], params[:mobile]).first
         # @visa = Visa.joins(:passport).where(unique_number: params[:unique_number], mobile: params[:mobile])
        end        
        raise "Unique number is not found. Enter valid number." if @visa.blank?
      rescue Exception => e
        @error = e.message
      end
    end
    
  end
end
