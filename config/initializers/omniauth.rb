OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "446246302141578", "c46e3008e98f6013bd72fecaf8d03bc0",
    :scope => 'email,user_birthday,read_stream', :display => 'popup'
end