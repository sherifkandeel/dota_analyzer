Dota.configure do |config|
    config.api_key =  Rails.application.credentials.STEAM_WEB_API_KEY
  
    # Set API version (defaults to "v1")
    # config.api_version = "v1"
  end