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
        raise "Either Unique number or registered number is not found. Enter valid number." if @visa.blank?
      rescue Exception => e
        @error = e.message
      end
    end    
  end
  
  def download_form
    path = File.join("#{Rails.root}", "app", "assets", "images", "thai_visa_form.pdf")
    send_file(path, options = {type: 'application/pdf', disposition: 'attachment', filename: 'thai_visa_form.pdf'}) 
  end
end
