Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, "647090469288-86tgirha1gptej5vu0om6dptotqfjaah.apps.googleusercontent.com", "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", scope: 'userinfo.email'
end
OmniAuth.config.allowed_request_methods = %i[get]