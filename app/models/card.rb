class Card < ApplicationRecord

  include AASM

  belongs_to :board
  has_one :user, through: :board

  validates :title, :description, presence: true
  validate :presence_of_starting_at, :check_end_date

  aasm :status, whiny_transitions: false do
    state :initialized, initial: true
    state :in_progress
    state :held
    state :archived
    state :resolved
    state :approved
    state :complete

    event :in_progress do
      transitions from: [:open, :hold], to: :in_progress
    end

    event :hold do
      transitions from: [:open, :hold], to: :held
    end

    event :approve do
      transitions from: [:resolved], to: :approved
    end

    event :complete do
      transitions from: [:in_progress], to: :complete
    end

    event :archive do
      transitions from: [:open, :in_progress, :hold], to: :archived
    end

    event :resolve do
      transitions from: [:approved], to: :resolved
    end

  end

  private

  def presence_of_starting_at
    if expiry_at?
      self.errors[:starting_at] << 'Start date must be present' unless starting_at?
    end
  end

  def check_end_date
    if expiry_at? && starting_at? && expiry_at < starting_at
      self.errors[:expiry_at] << 'End date must be greater than start date'
    end
  end

end
