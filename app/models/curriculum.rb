class Curriculum < ApplicationRecord
  belongs_to :language
  belongs_to :user

  has_many :lessons, dependent: :destroy
  has_many :cards, through: :lessons

  validates :title, :purpose, :start_date, :end_date, :context, presence: true

  def progress
    (lessons.sum{ |lesson| lesson.progress }) / lessons.length
  end

  def score
    (lessons.sum{ |lesson| lesson.score }) / lessons.length
  end
end

