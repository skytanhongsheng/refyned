class Curriculum < ApplicationRecord
  belongs_to :language
  belongs_to :user

  has_many :lessons, dependent: :destroy
  has_many :cards, through: :lessons
  has_many :curriculum_card_templates, dependent: :destroy
  has_many :card_templates, through: :curriculum_card_templates

  validates :title, :purpose, :start_date, :end_date, :context, presence: true
  validates :lesson_hours, presence: true, numericality: { greater_than: 0 }

  after_create :create_lessons

  def progress
    lessons.sum(&:progress).to_f / lessons.length
  end

  def score
    attempted_lessons = lessons.select do |lesson|
      lesson.cards.any? { |card| card.complete? }
    end

    return 0 if attempted_lessons.empty?

    lessons.filter(&:score).sum(&:score) / attempted_lessons.length
  end

  def create_lessons
    CreateCurriculumLessonsJob.perform_later(self) unless ENV['SEED']
  end
end
