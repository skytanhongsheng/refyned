require 'faker'

# # clear all tables
User.destroy_all
Language.destroy_all
Template.destroy_all
Curriculum.destroy_all

curriculum_file_path = File.join(__dir__, 'data', 'curricula.yml')
curriculum_content = YAML::load(File.open(curriculum_file_path))

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

TEMPLATE_NAMES.each { |name| Template.create!(name:) }

# ----------------------------------------------
# CURRICULA
# ----------------------------------------------
# first title will start from today and last a week
# other curriculum will start at a random date 7 days
# from today and up to 3 weeks from the date


curriculum_content["titles"].each_with_index do |title, index|
  start_date = Date.today
  start_date += rand(1..7).days if index.positive?

  end_date = start_date + rand(7..14).days

  curriculum = Curriculum.create!(
    title: title,
    purpose: curriculum_content["purposes"].sample,
    start_date: start_date,
    end_date: end_date,
    language: mandarin, # set Mandarin as default language for testing purposes
    user: jim, # set Jim as default user for testing purposes
    context: curriculum_content["context"].sample
  )

  puts "Creating lessons..."
  lesson_file_path = File.join(__dir__, 'data', 'lesson_plan.yml')
  lesson_plan_data = YAML::load(File.open(lesson_file_path))

  lesson_plan_data.each do |plan|
    Lesson.create!(
      title: plan["title"],
      description: plan["description"],
      curriciulum:
    )
  end

end

puts "Created curricula!"

# ----------------------------------------------
# LESSONS
# ----------------------------------------------



# Create 2 users
  # 1 - has curricula
  # 2 - no curricula

# create the languages
# create the templates
# create 3 curricula
  # - create N number of lessons
    # - create N number of cards
