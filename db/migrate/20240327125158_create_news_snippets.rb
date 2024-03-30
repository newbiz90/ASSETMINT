class CreateNewsSnippets < ActiveRecord::Migration[7.1]
  def change
    create_table :news_snippets do |t|
      t.references :ticker, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end
