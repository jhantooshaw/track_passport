class PassportsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_passport, only: [:edit, :show, :update, :destroy, :visa_status, :visas, :add_visa] 
  before_action :get_all_passports, only: [:index, :visa_status] 
  layout "admin"
  
  def index    
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
      @passport.destroy!
      flash[:notice] = "Passport is deleted successfully."
      redirect_to passports_path
    rescue Exception => e
      flash[:info] = e.message
      redirect_to passports_path
    end
  end
  
  def search
    case params[:search_type]
    when 'Email'
      @passports = Passport.where("email like ?", "#{params[:term]}%").paginate(:page => params[:page])
    when 'Mobile'
      @passports = Passport.where("mobile like ?", "#{params[:term]}%").paginate(:page => params[:page])
    when 'Passport'
      @passports = Passport.where("number like ?", "#{params[:term]}%").paginate(:page => params[:page])
    end
   
  end
  
  def visas
    @visas = @passport.visas
  end
  
  def visa_status 
    begin   
      @visa = @passport.visas.find(params[:visa_id])
      @visa.update_attributes!(status: params[:status])
      flash[:notice] = "Visa status is changed successfully."  
    rescue Exception => e
      puts "Exception: #{e.message}"
      flash.now[:warning] = e.message
      @error = e.message
    end
  end
  
  def add_visa
    if request.post?
      begin
        @passport.visas.create!(visa_type: params[:visa_type])
        @visas = @passport.visas
        flash[:info] = "Visa is added successfully."  
      rescue Exception => e
        puts "Exception: #{e.message}"
        flash.now[:warning] = e.message
        @error = e.message
      end
    end
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
    @passport = Passport.includes(:visas).find(params[:id])
  end
  
  def get_all_passports
    @passports =  Passport.paginate(:page => params[:page])
  end  
end