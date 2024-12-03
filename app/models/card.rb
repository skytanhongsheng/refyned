class Card < ApplicationRecord
  belongs_to :template
  belongs_to :lesson
  has_many :options, dependent: :destroy

  has_one_attached :picture
  has_one_attached :audio

  validates :instruction, :model_answer, :user_answer, presence: true

  after_save :score!, if: :will_save_change_to_user_answer?

  def complete?
    # [true, false].include?(correct)
    !correct.nil?
  end

  # called after user has submitted user_answer
  # call API if image_comprehention
  # check against model_answer for everything else
  # updates :correct
  def score!
    self.correct = true
  end
end
