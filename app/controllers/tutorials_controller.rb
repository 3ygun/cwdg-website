class TutorialsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :event_handler
  def index
    @tutorials = Tutorial.all
  end

  def show
    @tutorial = Tutorial.find(params[:id])
  end

  def event_handler
    # If this is a merge, sync the posts
    pull_request = params["pull_request"]
    if (request.headers["X-Github-Event"] == "pull_request" &&
      pull_request["state"] == "closed" &&
      pull_request["merged"] == true)

      SyncPostsJob.perform_later
    end

    render nothing: true
  end
end
