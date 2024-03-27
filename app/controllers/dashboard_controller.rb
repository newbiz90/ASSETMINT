class DashboardController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def index
    @followers_count = current_user.followers.count
    @following_count = current_user.following.count
  end
end
