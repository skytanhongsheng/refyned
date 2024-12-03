class Lesson < ApplicationRecord
  belongs_to :curriculum
  has_many :cards, dependent: :destroy

  validates :title, :description, :score, :progress, presence: true
  validates :score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }
  validates :progress, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }

  def next_card
    cards.where(correct: nil).first
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
end
