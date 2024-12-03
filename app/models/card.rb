class Card < ApplicationRecord
  belongs_to :template
  belongs_to :lesson
  has_many :options, dependent: :destroy

  has_one_attached :picture
  has_one_attached :audio

  validates :instruction, :model_answer, presence: true

  def complete?
    # [true, false].include?(correct)
    !correct.nil?
  end
end
