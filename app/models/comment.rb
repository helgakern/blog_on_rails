class Comment < ApplicationRecord
    belongs_to :post
    belongs_to :user
    validates :message, length: {minimum: 5}
  end