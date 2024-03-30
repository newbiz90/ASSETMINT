class PortfolioController < ApplicationController
  def index
    @users = User.all # or any other query to retrieve users
  end
end
