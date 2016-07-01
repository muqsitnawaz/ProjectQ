OmniAuth.config.full_host = "http://localhost:3000"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret,:skip_jwt => true,:scope => "userinfo.email,userinfo.profile",info_fields:'email,name'
  provider :twitter, Rails.application.secrets.twitter_client_id, Rails.application.secrets.twitter_client_secret,:scope => "userinfo.email,userinfo.profile",info_fields:'email,name'
end