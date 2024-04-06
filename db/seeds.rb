# Seed data for tickers
ticker1 = Ticker.create(name: 'AAPL')
ticker2 = Ticker.create(name: 'GOOGL')
ticker3 = Ticker.create(name: 'TSLA')
ticker4 = Ticker.create(name: 'HSBC')
ticker5 = Ticker.create(name: 'AMZN')

# Seed data for users
user1 = User.create(email: 'user1@example.com', password: 'password1', password_confirmation: 'password1')
user2 = User.create(email: 'user2@example.com', password: 'password2', password_confirmation: 'password2')
user3 = User.create(email: 'user3@example.com', password: 'password3', password_confirmation: 'password3')
user4 = User.create(email: 'user4@example.com', password: 'password4', password_confirmation: 'password4')
user5 = User.create(email: 'user5@example.com', password: 'password5', password_confirmation: 'password5')
user6 = User.create(email: 'user6@example.com', password: 'password6', password_confirmation: 'password6')
user7 = User.create(email: 'user7@example.com', password: 'password7', password_confirmation: 'password7')
user8 = User.create(email: 'user8@example.com', password: 'password8', password_confirmation: 'password8')
user9 = User.create(email: 'user9@example.com', password: 'password9', password_confirmation: 'password9')
user10 = User.create(email: 'user10@example.com', password: 'password10', password_confirmation: 'password10')
user11 = User.create(email: 'user11@example.com', password: 'password11', password_confirmation: 'password11')
user12 = User.create(email: 'user12@example.com', password: 'password12', password_confirmation: 'password12')
user13 = User.create(email: 'user13@example.com', password: 'password13', password_confirmation: 'password13')
user14 = User.create(email: 'user14@example.com', password: 'password14', password_confirmation: 'password14')
user15 = User.create(email: 'user15@example.com', password: 'password15', password_confirmation: 'password15')
user16 = User.create(email: 'user16@example.com', password: 'password16', password_confirmation: 'password16')
user17 = User.create(email: 'user17@example.com', password: 'password17', password_confirmation: 'password17')
user18 = User.create(email: 'user18@example.com', password: 'password18', password_confirmation: 'password18')
user19 = User.create(email: 'user19@example.com', password: 'password19', password_confirmation: 'password19')
user20 = User.create(email: 'user20@example.com', password: 'password20', password_confirmation: 'password20')

# Add more users if needed

# Seed data for user_tickers (associating users with tickers)
user_ticker1 = UserTicker.create(user: user1, ticker: ticker3)
user_ticker2 = UserTicker.create(user: user2, ticker: ticker2)
user_ticker3 = UserTicker.create(user: user2, ticker: ticker3)
user_ticker4 = UserTicker.create(user: user2, ticker: ticker4)
# You can associate users with tickers in any way you want, depending on your application's logic

# Seed data for subscriptions
subscription1 = Subscription.new(subscribable: user1, user: user2)
puts "Subscription 1 valid?: #{subscription1.valid?}"
puts "Subscription 1 errors: #{subscription1.errors.full_messages}"
subscription1.save

subscription2 = Subscription.new(subscribable: user2, user_ticker: user_ticker1)
puts "Subscription 2 valid?: #{subscription2.valid?}"
puts "Subscription 2 errors: #{subscription2.errors.full_messages}"
subscription2.save

subscription3 = Subscription.new(subscribable: user1, user_ticker: user_ticker4)
puts "Subscription 3 valid?: #{subscription3.valid?}"
puts "Subscription 3 errors: #{subscription3.errors.full_messages}"
subscription3.save

subscription4 = Subscription.new(subscribable: user1, user_ticker: user_ticker3)
puts "Subscription 4 valid?: #{subscription4.valid?}"
puts "Subscription 4 errors: #{subscription4.errors.full_messages}"
subscription4.save

subscription5 = Subscription.new(subscribable: user1, user_ticker: user_ticker2)
puts "Subscription 5 valid?: #{subscription5.valid?}"
puts "Subscription 5 errors: #{subscription5.errors.full_messages}"
subscription5.save

# Seed data for news_snippets
NewsSnippet.create(content: 'News snippet for AAPL', ticker: ticker1)
NewsSnippet.create(content: 'News snippet for GOOGL', ticker: ticker2)
# Add more news snippets if needed

# Verify UserTicker records
puts "UserTicker 1: #{user_ticker1.inspect}"
puts "UserTicker 2: #{user_ticker2.inspect}"

# Create a transaction for the first user_ticker
transaction1 = Transaction.new(user_ticker: user_ticker1, flow: 'Buy', txndate: Date.today, txnprice: 100.00, qty: 10, comment: 'Bought 10 shares of AAPL')
puts "Transaction 1 valid?: #{transaction1.valid?}"
puts "Transaction 1 errors: #{transaction1.errors.full_messages}"
transaction1.save

# Create a transaction for the second user_ticker
transaction2 = Transaction.new(user_ticker: user_ticker2, flow: 'Sell', txndate: Date.today, txnprice: 110.00, qty: 5, comment: 'Sold 5 shares of GOOGL')
puts "Transaction 2 valid?: #{transaction2.valid?}"
puts "Transaction 2 errors: #{transaction2.errors.full_messages}"
transaction2.save

# Create a transaction for the first user_ticker
transaction3 = Transaction.new(user_ticker: user_ticker1, flow: 'Buy', txndate: Date.today, txnprice: 100.00, qty: 10, comment: 'Bought 10 shares of AAPL')
puts "Transaction 3 valid?: #{transaction3.valid?}"
puts "Transaction 3 errors: #{transaction3.errors.full_messages}"
transaction3.save

# Create a transaction for the first user_ticker
transaction4 = Transaction.new(user_ticker: user_ticker1, flow: 'Sell', txndate: Date.today, txnprice: 90.00, qty: 90, comment: 'Sold 90 shares of AAPL')
puts "Transaction 4 valid?: #{transaction4.valid?}"
puts "Transaction 4 errors: #{transaction4.errors.full_messages}"
transaction4.save

# Create a transaction for the second user_ticker
transaction5 = Transaction.new(user_ticker: user_ticker3, flow: 'Sell', txndate: Date.today, txnprice: 110.00, qty: 5, comment: 'Sold 5 shares of X')
puts "Transaction 5 valid?: #{transaction2.valid?}"
puts "Transaction 5 errors: #{transaction2.errors.full_messages}"
transaction5.save

# Create a transaction for the second user_ticker
transaction6 = Transaction.new(user_ticker: user_ticker4, flow: 'Sell', txndate: Date.today, txnprice: 20.00, qty: 7, comment: 'Sold 7 shares of GOOGL')
puts "Transaction 6 valid?: #{transaction2.valid?}"
puts "Transaction 6 errors: #{transaction2.errors.full_messages}"
transaction6.save

# Create a transaction for the second user_ticker
transaction7 = Transaction.new(user_ticker: user_ticker4, flow: 'Buy', txndate: Date.today, txnprice: 63.00, qty: 11, comment: 'Bought 11 shares of A')
puts "Transaction 7 valid?: #{transaction2.valid?}"
puts "Transaction 7 errors: #{transaction2.errors.full_messages}"
transaction7.save

# Create a transaction for the second user_ticker
transaction8 = Transaction.new(user_ticker: user_ticker2, flow: 'Buy', txndate: Date.today, txnprice: 73.00, qty: 5, comment: 'Bought 5 shares of GOOGL')
puts "Transaction 8 valid?: #{transaction8.valid?}"
puts "Transaction 8 errors: #{transaction8.errors.full_messages}"
transaction8.save

# Create a transaction for the second user_ticker
transaction9 = Transaction.new(user_ticker: user_ticker3, flow: 'Sell', txndate: Date.today, txnprice: 110.00, qty: 5, comment: 'Sold 5 shares of GOOGL')
puts "Transaction 9 valid?: #{transaction9.valid?}"
puts "Transaction 9 errors: #{transaction9.errors.full_messages}"
transaction9.save

# Create a transaction for the second user_ticker
transaction10 = Transaction.new(user_ticker: user_ticker4, flow: 'Buy', txndate: Date.today, txnprice: 17.00, qty: 23, comment: 'Bought 23 shares of P')
puts "Transaction 10 valid?: #{transaction10.valid?}"
puts "Transaction 10 errors: #{transaction10.errors.full_messages}"
transaction10.save

puts "Seed Completed!"
