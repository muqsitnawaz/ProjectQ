OmniAuth.config.full_host = "http://localhost:3000"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, Rails.application.secrets.google_client_id, Rails.application.secrets.google_client_secret, :scope => "userinfo.email,userinfo.profile"
  # , { :provider_ignores_state => true }
end