LinkedIn.configure do |config|
  config.client_id = ENV["LINKEDIN_API_KEY"]
  config.client_secret = ENV["LINKEDIN_SECRET_KEY"]
  config.redirect_uri  = "http://localhost:3000/linkedin_callback"
end