OmniAuth.config.full_host = "http://localhost:3000"

Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['TEST_KEY'], ENV['TEST_SECRET'], { :scope => 'userinfo.email,userinfo.profile,https://www.googleapis.com/auth/calendar' } #'https://www.google.com/calendar/feeds/' }
end
