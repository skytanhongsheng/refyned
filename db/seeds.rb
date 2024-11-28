require 'faker'

# # clear all tables
User.destroy_all
Language.destroy_all
Template.destroy_all
Curriculum.destroy_all

# # ----------------------------------------------
# # USERS
# # ----------------------------------------------
# # Jim will have curricula assigned to him
jim = User.create!(
  email: 'jim@gmail.com',
  password: '123123',
  username: 'Jim'
)

# # Jane will be a new user with no curricula
jane = User.create!(
  email: 'jane@gmail.com',
  password: '123123',
  username: 'Jane'
)

# # ----------------------------------------------
# # LANGUAGES
# # ----------------------------------------------
# # creating a few languages, but will always
# # select Mandarin for the curricula
LANGUAGES = [
  'Mandarin',
  'English',
  'French',
  'Japanese',
  'German'
]

# # Create all the languages
puts "Creating languages..."
LANGUAGES.each { |name| Language.create!(name:) }
mandarin = Language.find_by(name: 'Mandarin')

puts "Created languages!"

# # ----------------------------------------------
# # TEMPLATES
# # ----------------------------------------------

# # create templates of cards
puts "Creating templates"
TEMPLATE_NAMES = [
  'Picture Comprehension',
  'Listening Comprehension',
  'MCQ'
]

TEMPLATE_NAMES.each

# # ----------------------------------------------
# # CURRICULA
# # ----------------------------------------------

# # create curricula elements

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

# # ----------------------------------------------
# # CURRICULA
# # ----------------------------------------------
# # first title will start from today and last a week
# # other curriculum will start at a random date 7 days
# # from today and up to 3 weeks from the date
CURRICULA_TITLES.each_with_index do |title, index|
  start_date = Date.today
  start_date += rand(1..7).days if index.positive?

  end_date = start_date + rand(7..14).days

  Curriculum.create!(
    title: title,
    purpose: CURRICULA_PURPOSES.sample,
    start_date: start_date,
    end_date: end_date,
    language: mandarin, # set Mandarin as default language for testing purposes
    user: jim, # set Jim as default userraia for testing purposes
    context: CURRICULA_CONTEXT.sample
  )
end

puts "Created curricula!"

# ----------------------------------------------
# LESSONS
# ----------------------------------------------

# puts "Creating lessons..."
# lesson_file_path = File.join(__dir__, 'data', 'lesson_plan.yml')
# lesson_plan_data = YAML::load(File.open(lesson_file_path))

# lesson_plan_data.each do |plan|
#   puts plan["title"]
#   puts plan["description"]
#   puts "---"
# end

# Create 2 users
  # 1 - has curricula
  # 2 - no curricula

# create the languages
# create the templates
# create 3 curricula
  # - create N number of lessons
    # - create N number of cards
