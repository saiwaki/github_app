class MainController < ApplicationController
  def index
    @client = Octokit::Client.new(access_token: Rails.application.secrets.github_access_token)
    p @cilent.rate_limit
    raise
  end
end
