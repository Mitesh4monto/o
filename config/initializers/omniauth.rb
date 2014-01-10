OmniAuth.config.logger = Rails.logger

OmniAuth.config.on_failure = Proc.new { |env|
  OmniAuth::FailureEndpoint.new(env).redirect_to_failure
}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "446246302141578", "c46e3008e98f6013bd72fecaf8d03bc0",
    :scope => 'publish_stream, offline_access, email', :display => 'popup'

end