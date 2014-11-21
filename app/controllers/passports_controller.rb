class PassportsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_passport, only: [:edit, :show, :update, :destroy, :change_status, :visas] 
  layout "admin"
  def index
    @passports =  Passport.paginate(:page => params[:page])
  end
  
  def new
    @passport = Passport.new
  end
  
  
  def create
    @passport = Passport.new(passport_params)
    
    begin
      @passport.visas.build(visa_params)
      @passport.save!
     
      #PassportMailer.send_email(@passport).deliver
      flash[:notice] = "Passport is created successfully. An email and text message is sent to respective email and mobile number."
      redirect_to passports_path
    rescue Exception => e
      flash.now[:info] = e.message
      render 'new'
    end
  end
 
  def update    
    begin     
      @passport.visas.build(visa_params)
      @passport.update_attributes!(update_passport_params)
      flash[:notice] = "Passport is updated successfully."
      redirect_to passports_path
    rescue Exception => e
      flash.now[:info] = e.message
      render 'edit'
    end
  end
  
  def destroy
    begin     
      @passportsd.destroy!
      flash[:notice] = "Passport is deleted successfully."
      redirect_to passports_path
    rescue Exception => e
      flash[:info] = e.message
      redirect_to passports_path
    end
  end
  
  def search
    @passports = Passport.where("number=? or email=? or mobile=?", params[:term], params[:term], params[:term]).paginate(:page => params[:page])
  end
  
  def visas
    @visas = @passport.visas
  end
  
  def change_status
    @visa = @passport.visas.find(params[:visa_id])
  end
  
  
  private
  
  def passport_params
    params.require(:passport).permit(:first_name, :last_name, :dob, :email, :mobile, :number, :expiry_date)
  end
  
  def update_passport_params
    params.require(:passport).permit(:first_name, :last_name, :dob, :email, :mobile, :number, :expiry_date, :status)
  end
  
  def visa_params
    params[:passport][:visa].permit(:visa_type)
  end
 
  def get_passport
    @passport = Passport.find(params[:id])
  end
  
end
