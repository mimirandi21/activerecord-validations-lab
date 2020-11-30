class Post < ActiveRecord::Base
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { within: %w(Fiction Non-Fiction), 
        message: "%{value} is not a valid option" }
    validate :clickbait_title

    Clickbait_matches = [
        "Won't Believe",
        "Secret",
        "Top[number]",
        "Guess"
    ]

    def clickbait_title
        if title.present? && Clickbait_matches.none? { |p| title.match(p)}
            errors.add(:clickbait, "needs to be more clickbait-y")
        end
    end
end
