class AddStuffToNewsSnippet < ActiveRecord::Migration[7.1]
  def change
    add_column :news_snippets, :title, :string
    add_column :news_snippets, :article_url, :string
    add_column :news_snippets, :keywords, :jsonb
    add_column :news_snippets, :tickers, :jsonb
    add_column :news_snippets, :publisher_logo_url, :string
    add_column :news_snippets, :publisher_name, :string
  end
end
