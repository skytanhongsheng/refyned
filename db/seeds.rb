require 'faker'

# ----------------------------------------------
# USERS
# ----------------------------------------------
# Jim will have curricula assigned to him
jim = User.new(
  email: 'jim@gmail.com',
  password: '123123',
  username: 'Jim'
)

# Jane will be a new user with no curricula
jane = User.new(
  email: 'jane@gmail.com',
  password: '123123',
  username: 'Jane'
)

# ----------------------------------------------
# LANGUAGES
# ----------------------------------------------
# creating a few languages, but will always
# select Mandarin for the curricula
LANGUAGES = [
  'Mandarin',
  'English',
  'French',
  'Japanese',
  'German'
]

# Create all the languages
puts "Creating languages..."
LANGUAGES.each { |name| Language.create!(name:) }
mandarin = Language.find_by(name: 'Mandarin')

puts "Created languages!"

# ----------------------------------------------
# TEMPLATES
# ----------------------------------------------

# create templates of cards
# puts 'Creating templates'
# TEMPLATE_NAMES = [
#   'Picture Comprehension',
#   'Listening Comprehension',
#   'MCQ'
# ]

# template = Template.new(
#   name: TEMPLATE_NAMES.sample
# )

# puts 'Created templates'

# ----------------------------------------------
# CURRICULA
# ----------------------------------------------

# create curricula
puts "Creating curricula..."
CURRICULA_TITLES = [
  'Mandarin for Travelers: Essential Phrases',
  'Mandarin travel phrases you need to know',
  'Mandarin for Business Professionals'
]

CURRICULA_PURPOSES = [
  'enhance travel experiences',
  'cultural immersion',
  'build connections with locals',
  'enhance career opportunities',
  'navigate the chinese market',
  'improve cross-cultural communication'
]

CURRICULA_CONTEXT = [
  'watch and enjoy Chinese dramas',
  'have to reach intermediate level in order to get a promotion',
  'to enrol in a university in Beijing',
  'speak with locals in Xian',
  'work with international clients',
  'go on student exchange in Wuhan'
]

CURRICULA_TITLES.each do |title|
  curriculum = Curriculum.new(
    title: title,
    purpose: CURRICULA_PURPOSES.sample,
    duration: rand(7..14),
    language: mandarin, # set Mandarin as default language for testing purposes
    user: jim, # set Jim as default user for testing purposes
    context: CURRICULA_CONTEXT.sample
  )
end

# Create 2 users
  # 1 - has curricula
  # 2 - no curricula

# create the languages
# create the templates
# create 3 curricula
  # - create N number of lessons
    # - create N number of cards

lesson_file_path = File.join(__dir__, 'data', 'lesson_plan.yml')
lesson_plan_data = YAML::load(File.open(lesson_file_path))

lesson_plan_data["lesson_plan"].each do |day|
  p day
  puts "---"
end
