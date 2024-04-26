def search
  @search_performed = true  # This flag indicates a search was performed
  if params[:search] && params[:search][:email].present?
    @users = User.where(email: params[:search][:email])
  else
    @users = User.none
  end

  render 'index'  # Or render another view that you are using for display
end
