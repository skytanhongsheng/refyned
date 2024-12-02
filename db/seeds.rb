require 'faker'
require 'json'

# # clear all tables
Card.destroy_all
Lesson.destroy_all
Curriculum.destroy_all
User.destroy_all
Language.destroy_all
Template.destroy_all

puts "cleared all tables"

curriculum_file_path = File.join(__dir__, 'data', 'curricula.yml')
CURRICULUM_CONTENT = YAML::load(File.open(curriculum_file_path))

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

puts 'Created users!'

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
puts "Creating templates..."
TEMPLATE_NAMES = [
  'Picture Comprehension',
  'Listening Comprehension',
  'MCQ'
]

TEMPLATE_NAMES.each { |name| Template.create!(name:) }

puts "Created templates!"

# ----------------------------------------------
# CURRICULA
# ----------------------------------------------
# first title will start from today and last a week
# other curriculum will start at a random date 7 days
# from today and up to 3 weeks from the date

# parse card data from json
cards_file_path = File.join(__dir__, 'data', 'cards.json')
puts cards_file_path
cards_json = "";
File.open(cards_file_path, "r") { |file| cards_json = JSON.parse(file.read, { symbolize_names: true }) }

puts "Creating curricula and lessons..."
CURRICULUM_CONTENT["titles"].each_with_index do |title, index|
  start_date = Date.today
  start_date += rand(1..7).days if index.positive?

  end_date = start_date + rand(7..14).days

  curriculum = Curriculum.create!(
    title: title,
    purpose: CURRICULUM_CONTENT["purposes"].sample,
    start_date: start_date,
    end_date: end_date,
    language: mandarin, # set Mandarin as default language for testing purposes
    user: jim, # set Jim as default user for testing purposes
    context: CURRICULUM_CONTENT["context"].sample
  )

  # ----------------------------------------------
  # LESSONS
  # ----------------------------------------------

  lesson_file_path = File.join(__dir__, 'data', 'lesson_plan.yml')
  lesson_plan_data = YAML::load(File.open(lesson_file_path))

  # only generate first 3 lessons to reduce seed time
  lesson_plan_data.first(2).each do |plan|
    lesson = Lesson.create!(
      title: plan["title"],
      description: plan["description"],
      curriculum:,
      score: rand,
      progress: rand
    )

    # seed 1 card for each card template
    cards_json.each do |card_args|
      card = Card.new(
        lesson: lesson,
        instruction: card_args[:instruction],
        context: card_args.key?(:context) ? card_args[:context]: nil,
        model_answer: card_args[:answer],
        template: Template.find_by(name: card_args[:template])
      )
      if card_args.key?(:picture)
        file_path = File.join(Rails.root, *card_args[:picture])
        file = File.open(file_path)
        card.picture.attach(io: file, filename: "sample_card_picture.jpg", content_type: "image/png")
      end
      if card_args.key?(:audio)
        file_path = File.join(Rails.root, *card_args[:audio])
        file = File.open(file_path)
        card.audio.attach(io: file, filename: "sample_card_audio.mp3", content_type: "audio/mpeg")
      end
      if card_args.key?(:options)
        card_args[:options].each { |option| Option.create!(card: card, content: option)}
      end
      card.save!
      puts "Creating card"
    end

    # card_count = rand(5..10)
    # card_count.times do |i|

    #   Card.create!(
    #     lesson: lesson,
    #     correct: i >= card_count / 2 ? nil : [true, false].sample,
    #     instruction: 'Translate the following sentence:',
    #     context: 'This is a big house.',
    #     answer: '这是一栋大房子。',
    #     template: Template.all.sample
    #   )
    # end
  end
end

puts "Created curricula, lessons and cards!"
