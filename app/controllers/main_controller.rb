class MainController < ApplicationController
  def index
    @courses = Course.all
    @course = Course.first
    @new = Course.new
  end

  def create
    @try = course_params
    @array = [@try["user"],@try["repo"],@try["sha"]]
    raise
  end

  private

  def course_params
    params.require(:try).permit(:user, :repo, :sha)
  end
end
