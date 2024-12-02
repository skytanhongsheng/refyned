class Card < ApplicationRecord
  belongs_to :template
  belongs_to :lesson
  has_many :options, dependent: :destroy

  has_one_attached :picture
  has_one_attached :audio

  validates :instruction, :answer, presence: true

  def template_path
    template_name = self.template.name.downcase.gsub(' ', '_')
    "cards/templates/#{template_name}"
  end
end
