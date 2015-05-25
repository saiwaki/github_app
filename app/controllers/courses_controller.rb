class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def show
    @course = Course.find(params[:id])
    @blobs = @course.blob
    @diff = GitDiff.from_string(@course.diff)
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @client = Octokit::Client.new(access_token: Rails.application.secrets.github_access_token)

    @commit = @client.commit "#{@course.user}/#{@course.repo}" ,@course.sha, {accept: "application/vnd.github.v3.diff"}
    @course.diff = @commit

    @commit_state = @client.commit "#{@course.user}/#{@course.repo}" ,@course.sha
    # @course.summary = @commit_state.commit.message

    @blob = Array.new
    @commit_state.files.each_with_index do |file, index|
      obj =  @client.blob "#{@course.user}/#{@course.repo}", @commit_state.files[index].sha , {accept: "application/vnd.github.v3.raw"}
      @blob << obj
    end
    @course.blob = @blob

    @commit_detail = @client.git_commit "#{@course.user}/#{@course.repo}" ,@course.sha
    # @course.description = @commit_detail.message

    @course.description = ""
    @commit_detail.message.each_line.with_index do |line, index|
      if index == 0
        @course.summary = line
      else
        @course.description = @course.description + line
      end
    end

    respond_to do |format|
      if @course.save
        format.html { redirect_to course_url(@course), notice: 'successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private

  def course_params
    params.require(:course).permit(:user, :repo, :sha)
  end
end
