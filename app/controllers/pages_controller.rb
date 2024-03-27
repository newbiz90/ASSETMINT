class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: :home

  def home
    @followers_count = current_user.followers.count
    @following_count = current_user.following.count
  end
end
