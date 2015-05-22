Octokit.configure do |config|
  if Rails.env.production?
    config.client_id     = Rails.application.secrets.github_client_id
    config.client_secret = Rails.application.secrets.github_client_secret
  end
  @client = Octokit::Client.new(access_token: "fb030e9ff9ee9eeef2a9a0217fa8d6a590093ee1")
end
