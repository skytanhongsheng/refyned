class Curriculum < ApplicationRecord
  belongs_to :language
  belongs_to :user

  has_many :lessons, dependent: :destroy
  has_many :cards, through: :lessons
  has_many :curriculum_card_templates, dependent: :destroy
  has_many :card_templates, through: :curriculum_card_templates

  validates :title, :purpose, :start_date, :end_date, :context, presence: true
  validates :lesson_hours, presence: true, numericality: { greater_than: 0 }
  validates :card_templates, length: { minimum: 1, too_short: "need to have at least 1 card template" }

  after_create :create_lessons

  def progress
    lessons.empty? ? 0 : lessons.sum(&:progress).to_f / lessons.length
  end

  def score
    attempted_lessons = lessons.select do |lesson|
      lesson.cards.any? { |card| card.attempted? }
    end

    return 0 if attempted_lessons.empty?

    lessons.filter(&:score).sum(&:score) / attempted_lessons.length
  end

  def create_lessons
    CreateCurriculumLessonsJob.perform_later(self) unless ENV['SEED']
  end

  def card_counts
    card_templates.each_with_object({}) do |template, card_counts|
      if ['picture_comprehension', 'listening_comprehension'].include? template.to_snake_case
        card_counts[template.to_snake_case] = 2
      else
        card_counts[template.to_snake_case] = rand(4..8)
      end
    end
  end
end
