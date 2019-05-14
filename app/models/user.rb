class User < ApplicationRecord

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable

  has_many :boards, dependent: :destroy
  has_many :cards, through: :boards, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :firstname, :lastname, presence: true
  validates :email,
            format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i},
            uniqueness: true,
            presence: true

end
