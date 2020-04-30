class Post < ApplicationRecord

    has_many :comments, dependent: :destroy
    belongs_to :user

    before_save :capitalize_title

    validates :title, presence: true , uniqueness: {case_sensitive: false}
    validates :body, presence: true
    validates :body, length: {minimum: 10}
    
    private

    def capitalize_title
        self.title.capitalize!
    end

end