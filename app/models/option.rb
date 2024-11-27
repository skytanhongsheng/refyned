class Option < ApplicationRecord
  belongs_to :card

  # Nice to have
  # Options could include multiple choices of pictures or audio
  has_one_attached :picture
  has_one_attached :audio

  validates :content, presence: true
end
