require 'faker'

# create languages
LANGUAGES = [
  'Mandarin',
  'English',
  'French',
  'Japanese',
  'German'
]

language = Language.new(
  name: LANGUAGES.first
)

puts 'Created languages'

# create templates of cards
TEMPLATE_NAMES = [
  'Picture Comprehension',
  'Listening Comprehension',
  'MCQ'
]

template = Template.new(
  name: TEMPLATE_NAMES.sample
)

puts 'Created templates'
