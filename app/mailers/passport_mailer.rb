class PassportMailer < ActionMailer::Base
  default from: "no-reply@trackpassport.com"
  
  def send_email(passport, visa)
    @passport = passport
    @visa = visa
    #@url  = 'http://example.com/login'
    mail(to: @passport.email, subject: 'Application is received')
  end
end
