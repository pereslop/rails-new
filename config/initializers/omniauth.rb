Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET'],
           callback_url: "http://localhost:3000/users/auth/facebook/callback",
           image_size: :large
end