class Board < ApplicationRecord

  belongs_to :user
  has_many :cards

  validates :description, presence: true
  validates :title, uniqueness: true, presence: true

  before_destroy :check_for_cards

  private

  def check_for_cards
    if cards.count > 0
      errors.add(:base, "cannot delete board while cards exist")
      throw :abort
    end
  end

end
