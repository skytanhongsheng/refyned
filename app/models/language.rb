class Language < ApplicationRecord
  has_many :curricula, dependent: :destroy
  validates :name, presence: true
end
