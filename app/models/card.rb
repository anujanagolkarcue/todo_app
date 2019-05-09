class Card < ApplicationRecord

  include AASM  

  belongs_to :board
  has_one :user, through: :board

  aasm do
    state :open, initial: true
    state :in_progress
    state :held
    state :archived
    state :complete

    event :in_progress do
      transition from: [:open, :hold], to: :in_progress
    end
    
    event :hold do
      transition from: [:open, :hold], to: :held
    end
    
    event :archive do
      transition from: [:open, :in_progress, :hold], to: :archived 
    end
    
    event :complete do
      transition from: [:in_progress], to: :complete
    end

  end

end
