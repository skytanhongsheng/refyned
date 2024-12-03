class Lesson < ApplicationRecord
  belongs_to :curriculum
  has_many :cards, dependent: :destroy

  validates :title, :description, :score, :progress, presence: true
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }

  # find the first card in the lesson where the
  # correct key is nil. This would represent the
  # "next" card.
  # if card is passed as an argument, return the
  # next card from that provided card
  def next_card(card = nil)
    incomplete_cards = self.cards.where(correct: nil).order(:id)

    if card.nil?
      incomplete_cards.first
    else
      index = incomplete_cards.find_index(card)
      incomplete_cards[index + 1]
    end
  end
end
