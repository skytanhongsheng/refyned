class Lesson < ApplicationRecord
  belongs_to :curriculum
  has_many :cards, dependent: :destroy

  validates :title, :description, :score, :progress, presence: true
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }

  def next_card
    self.cards.where(correct: nil).first
  end
end
