class Comment < ApplicationRecord

  belongs_to :user
  belongs_to :card

  validates :body, :user_id, :card_id, presence: true

end
