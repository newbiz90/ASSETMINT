json.extract! transaction, :id, :asset_id, :flow, :txndate, :txnprice, :qty, :comment, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
