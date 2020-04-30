class Post < ApplicationRecord

    validates :title, {
        presence: true,
        uniqueness: { case_sensitive: true}
    }

    validates :body, {
        presence: true,
        length: { minimum: 50}
    }
end