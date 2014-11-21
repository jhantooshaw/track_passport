class PassportMailer < ActionMailer::Base
  default from: "no-reply@trackpassport.com"
  
  def send_email(passport)
    @passport = passport
    #@url  = 'http://example.com/login'
    mail(to: @passport.email, subject: 'Passport is created')
  end
end
