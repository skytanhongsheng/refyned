class Curriculum < ApplicationRecord
  belongs_to :language
  belongs_to :user

  has_many :lessons, dependent: :destroy
  has_many :cards, through: :lessons

  validates :title, :purpose, :duration, :context, presence: true
end
