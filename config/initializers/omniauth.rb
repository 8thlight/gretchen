Rails.application.config.middleware.use OmniAuth::Builder do
    provider :google_oauth2, ENV['TEST_KEY'], ENV['TEST_SECRET'], {
  }
end
