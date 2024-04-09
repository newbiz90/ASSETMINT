class CommunityController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def index
    @users = User.all
  end
end
