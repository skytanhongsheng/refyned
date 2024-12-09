class Lesson < ApplicationRecord
  belongs_to :curriculum
  has_many :cards, dependent: :destroy

  validates :title, :description, presence: true

  def first_card
    cards.order(:id).first
  end

  def next_lesson
    curriculum.lessons.find_by(order: order + 1)
  end

  def status
    completed = cards.pluck(:correct)

    if completed.all?(&:nil?)
      "pending"
    elsif completed.any?(&:nil?)
      "started"
    else
      "completed"
    end
  end

  # find the first card in the lesson where the
  # correct key is nil. This would represent the
  # "next" card.
  # if card is passed as an argument, return the
  # next card from that provided card
  def next_card(mode, card = nil, include_answered = false)
    cardset = include_answered ? cards.order(:id) : cards.where(correct: nil).order(:id)

    if mode == 'learning' && status != "completed"
      cardset = cardset.select do |c|
        Card::LEARNING_TEMPLATES.include?(c.card_template.name)
      end
    end

    if card.nil?
      cardset.first
    else
      index = cardset.find_index(card)
      index.nil? ? cardset.first : cardset[index + 1]
    end
  end

  def score
    correct = cards.where(correct: true).length
    wrong = cards.where(correct: false).length
    (correct + wrong).positive? ? correct.to_f / (correct + wrong) : 0
  end

  def progress
    cards.empty? ? 0 : cards.reject { |card| card.correct.nil? }.length.to_f / cards.length
  end

  def completed_cards
    cards.where.not(correct: nil)
  end

  def incomplete_cards
    cards.where(correct: nil)
  end

  def bookmarks
    cards.where(bookmarked: true)
  end
end
