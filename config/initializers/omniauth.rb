Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.FACEBOOK_APP_ID, Rails.application.secrets.FACEBOOK_APP_SECRET,
           image_size: :large
  provider :google_oauth2, Rails.application.secrets.GOOGLE_APP_ID, Rails.application.secrets.GOOGLE_APP_SECRET
end