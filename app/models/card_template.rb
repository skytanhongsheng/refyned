class CardTemplate < ApplicationRecord
  has_many :cards, dependent: :destroy

  validates :name, presence: true, inclusion: { in: [
    "Picture Comprehension",
    "Listening Comprehension",
    "MCQ",
    "Translate"
  ] }
end
