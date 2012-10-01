require 'openid/store/filesystem'

# GitHub
# Client ID = 1af63ebdb3633bbdfdcc
# Client Secret = 5b28be8251d2b7805ac02b5d9a8656ceb776b2c1

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :shibboleth, {
    :shib_session_id_field     => "Shib-Session-ID",
    :shib_application_id_field => "Shib-Application-ID",
    :debug                     => false,
    :extra_fields => [
      :"unscoped-affiliation",
      :entitlement
    ]
  }
  provider :github, "1af63ebdb3633bbdfdcc", "5b28be8251d2b7805ac02b5d9a8656ceb776b2c1"
  #provider :github, ENV['GITHUB_KEY'], ENV['GITHUB_SECRET']

end
