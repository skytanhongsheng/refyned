class CreateLessonCardsJob < ApplicationJob
  queue_as :default

  def perform(lesson)
    # get cards info from API service
    cards_info = CreateLessonCardsService.new.generate_cards_info(lesson)

    puts "Creating Cards"
    # create cards from cards info
    cards_info.each { |card_info| create_lesson_card(lesson, card_info) }
  end

  private

  # create a lesson card from card info
  def create_lesson_card(lesson, card_info)
    card = Card.new(
      instruction: card_info[:instruction],
      template: Template.find_by(name: card_info[:template]),
      model_answer: card_info[:answer],
      lesson: lesson
    )
    # check context and set context to appropriate columns accordingly
    set_card_context(card, card_info[:context])

    # add options if exist
    card.options = card_info[:options].map { |option| Option.new(content: option) } if card_info.key?(:options)

    # create card
    card.save!
  end

  # helper method to set card context for the create_lesson_card() method
  def set_card_context(card, context)
    if context.instance_of?(String)
      card.context = context
    else
      # TODO: change hard coded files
      file_path = File.join(Rails.root, "app", "assets", "audio", "sample_card_audio.mp3")
      file = File.open(file_path)
      if context[:type] == "audio/mpeg"
        card.audio.attach(io: file, filename: "sample_card_audio.mp3", content_type: "audio/mpeg")
      elsif context[:type] == "image/png"
        card.picture.attach(io: file, filename: "sample_card_picture.jpg", content_type: "image/png")
      end
    end
  end
end
