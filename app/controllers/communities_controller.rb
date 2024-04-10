class CommunitiesController < ApplicationController
  before_action :authenticate_user! # Ensure user is authenticated

  def show
    @users = User.all
  end
end
