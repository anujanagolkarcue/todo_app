class Card < ApplicationRecord

  include AASM

  belongs_to :board
  has_one :user, through: :board
  has_many :comments, autosave: true
  # has_many_attached :attachment

  validates :title, :description, presence: true
  validate :presence_of_starting_at, :check_end_date

  before_destroy :validate_before_destroy

  aasm :status, whiny_transitions: false do
    state :initialized, initial: true
    state :in_progress
    state :held
    state :archived
    state :resolved
    state :approved
    state :complete

    event :in_progress do
      transitions from: [:initialized, :held], to: :in_progress
    end

    event :hold do
      transitions from: [:initialized, :in_progress], to: :held
    end

    event :approve do
      transitions from: [:complete], to: :approved
    end

    event :complete do
      transitions from: [:in_progress], to: :complete
    end

    event :archive do
      transitions from: [:initialized, :in_progress, :held], to: :archived
    end

    event :resolve do
      transitions from: [:approved], to: :resolved
    end

  end

  def self.events_with_transition_state
    collect = {}
    Card.aasm(:status).events.map { |e| collect[e.name.to_sym] = e.transitions.map(&:to).uniq.first }
    collect
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

  def validate_before_destroy
    if comments.count > 0
      errors.add(:base, "cannot delete card while comments are present")
      throw :abort
    elsif !initialized?
      errors.add(:base, "cannot delete card while it has been moved to other state")
      throw :abort
    end
  end

end
