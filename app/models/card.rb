class Card < ApplicationRecord
  belongs_to :card_template
  belongs_to :lesson
  has_many :options, dependent: :destroy

  has_one_attached :picture
  has_one_attached :audio

  validates :instruction, :model_answer, presence: true

  before_validation :check_empty
  before_save :score!, if: :will_save_change_to_user_answer?

  def complete?
    # [true, false].include?(correct)
    !correct.nil?
  end

  # called after user has submitted user_answer
  # call API if image_comprehension
  # check against model_answer for everything else
  # updates :correct
  def score!
    self.correct = card_template.name == "picture_comprehension" ? similarity_comparison : direct_comparison
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
    AnswerSimilarityService.is_correct?(id, user_answer, model_answer)
  end
end
