# Seed data for tickers
ticker1 = Ticker.create(name: 'AAPL')
ticker2 = Ticker.create(name: 'GOOGL')

# Seed data for users
user1 = User.create(email: 'user1@example.com', password: 'password1', password_confirmation: 'password1')
user2 = User.create(email: 'user2@example.com', password: 'password2', password_confirmation: 'password2')
# Add more users if needed

# Seed data for user_tickers (associating users with tickers)
user_ticker1 = UserTicker.create(user: user1, ticker: ticker1)
user_ticker2 = UserTicker.create(user: user2, ticker: ticker2)
# You can associate users with tickers in any way you want, depending on your application's logic

# Seed data for news_snippets
NewsSnippet.create(content: 'News snippet for AAPL', ticker: ticker1)
NewsSnippet.create(content: 'News snippet for GOOGL', ticker: ticker2)
# Add more news snippets if needed

# Verify UserTicker records
puts "UserTicker 1: #{user_ticker1.inspect}"
puts "UserTicker 2: #{user_ticker2.inspect}"

# Create a transaction for the first user_ticker
transaction1 = Transaction.new(user_tickers_id: 1, flow: 'Buy', txndate: Date.today, txnprice: 100.00, qty: 10, comment: 'Bought 10 shares of AAPL')
puts "Transaction 1 valid?: #{transaction1.valid?}"
puts "Transaction 1 errors: #{transaction1.errors.full_messages}"

# Create a transaction for the second user_ticker
transaction2 = Transaction.new(user_tickers_id: 2, flow: 'Sell', txndate: Date.today, txnprice: 110.00, qty: 5, comment: 'Sold 5 shares of GOOGL')
puts "Transaction 2 valid?: #{transaction2.valid?}"
puts "Transaction 2 errors: #{transaction2.errors.full_messages}"

puts "Seed Completed!"
