class NewsSnippet < ApplicationRecord
  belongs_to :ticker

  # Add any validations or methods specific to the NewsSnippet model here

  validates :title, uniqueness: { scope: :content }
end
