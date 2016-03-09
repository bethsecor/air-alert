class TweetsController < ApplicationController
  def create
    air_quality_tweet = current_user.tweet(twitter_params[:message])
    # binding.pry
    flash[:tweet] = "Successfully tweeted!"
    redirect_to airquality_path
  end

  private

    def twitter_params
      params.require(:tweet).permit(:message)
    end
end
