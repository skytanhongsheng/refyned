class Card < ApplicationRecord
  belongs_to :card_template
  belongs_to :lesson
  has_many :options, dependent: :destroy

  has_one_attached :picture
  has_one_attached :audio

  validates :instruction, :model_answer, presence: true

  before_validation :check_empty
  before_save :score!, if: :will_save_change_to_user_answer?

  LEARNING_TEMPLATES = [
    "Listening Comprehension",
    "MCQ",
    "Translate"
  ]

  def attempted?
    # [true, false].include?(correct)
    !correct.nil?
  end

  # called after user has submitted user_answer
  # call API if image_comprehension
  # check against model_answer for everything else
  # updates :correct
  def score!
    if card_template.name == "Picture Comprehension"
      CardScoringJob.perform_later(id, user_answer, model_answer)
    else
      self.correct = direct_comparison
    end
  end

  def calculating_score?
    !user_answer.nil? && correct.nil?
  end

  def learn?
    LEARNING_TEMPLATES.include? card_template.name
  end

  private

  def check_empty
    self.user_answer = nil if user_answer == ""
  end

  # For a MCQ question, this is the scoring method:
  def direct_comparison
    user_answer == model_answer
  end

  # For a Picture Comprehension question, this is the scoring method:
  def similarity_comparison
    CardScoringJob.perform_later(id, user_answer, model_answer)
  end
end
