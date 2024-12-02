class Card < ApplicationRecord
  belongs_to :template
  belongs_to :lesson
  has_many :options, dependent: :destroy

  has_one_attached :picture
  has_one_attached :audio

  validates :instruction, :answer, presence: true

  def template_name
    # find the name of the template
    # convert it to lower_snake_case
    # i.e Picture Comprehension => picture_comprehension
  end
end
