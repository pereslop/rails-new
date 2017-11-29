Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.FACEBOOK_APP_ID, Rails.application.secrets.FACEBOOK_APP_SECRET,
           callback_url: "http://localhost:3000/users/auth/facebook/callback",
           image_size: :large
end