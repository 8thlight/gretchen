ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :user_name            => "8thlight.artisan",
  :password             => "Craft5man",
  :authentication       => "plain",
  :enable_starttls_auto => true
}
