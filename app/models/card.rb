class Card < ApplicationRecord
  belongs_to :template
  has_many :options, dependent: :destroy

  has_one_attached :picture
  has_one_attached :audio

  validates :bookmarked, :instruction, :answer, presence: true

end
