# POST /user_tickers
def create
  @user_ticker = UserTicker.new(user_ticker_params)
  @user_ticker.user = current_user

  if @user_ticker.save
    current_user.generate_news_for_my_tickers
    redirect_to user_tickers_path, notice: 'Ticker added and news updated.'
  else
    render :new
  end
end

private

def user_ticker_params
  params.require(:user_ticker).permit(:ticker_id)
end
