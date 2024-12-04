# 1. showing audio file
# 2. comparing user answer with model answer
# 3. mark the user answer
  # correct: true | false | nil

require 'faker'
require 'json'

# set environment variable to disable after create background jobs
ENV['SEED'] = 'true'

# # clear all tables
Card.destroy_all
Lesson.destroy_all
Curriculum.destroy_all
User.destroy_all
Language.destroy_all
CardTemplate.destroy_all

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
  'MCQ',
  'Translate'
]

TEMPLATE_NAMES.each { |name| CardTemplate.create!(name:) }

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
cards_info = "";
File.open(cards_file_path, "r") { |file| cards_info = JSON.parse(file.read, { symbolize_names: true }) }

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

  lesson_plan_data.first(2).each_with_index do |plan, index|
    lesson = Lesson.create!(
      title: plan["title"],
      description: plan["description"],
      curriculum:,
      score: rand,
      progress: rand,
      order: index + 1,
      status: "pending"
    )

    # helper method to set card context
    def set_card_context(card, context)
      if context.instance_of?(String)
        card.context = context
      else
        if context[:type] == "audio/mpeg"
          file_path = File.join(Rails.root, "app", "assets", "audio", "sample_card_audio.mp3")
          file = File.open(file_path)
          card.audio.attach(io: file, filename: "sample_card_audio.mp3", content_type: "audio/mpeg")
        elsif context[:type] == "image/png"
          file_path = File.join(Rails.root, "app", "assets", "images", "sample_card_picture.jpg")
          file = File.open(file_path)
          card.picture.attach(io: file, filename: "sample_card_picture.jpg", content_type: "image/png")
        end
      end
    end

    # seed 1 card for each card template
    cards_info.each do |card_info|
      card = Card.new(
        instruction: card_info[:instruction],
        card_template: CardTemplate.find_by(name: card_info[:template]),
        model_answer: card_info[:answer],
        lesson: lesson
      )
      # check context and set context to appropriate columns accordingly
      set_card_context(card, card_info[:context])

      # add options if exist
      card.options = card_info[:options].map { |option| Option.new(content: option) } if card_info.key?(:options)

      # create card
      card.save!
      puts "Created card"
    end
  end
end

puts "Created curricula, lessons and cards!"

# remove environment variable after seeding is done
ENV.delete('SEED')
