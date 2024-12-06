class CreateLessonCardsJob < ApplicationJob
  queue_as :default

  def perform(lesson)
    # get cards info from API service
    cards_info = CreateLessonCardsService.new(lesson).generate_cards_info

    # create cards from cards info
    cards_info.each { |card_info| create_lesson_card(lesson, card_info) }
  end

  private

  # create a lesson card from card info
  def create_lesson_card(lesson, card_info)
    # assign general details
    card = Card.new(default_details(card_info))

    # assign the lesson
    card.lesson = lesson

    # check context and set context to appropriate columns accordingly
    card = set_card_context(card, card_info["context"])

    # add options if exist
    card.options = set_card_options(card_info) if card_info.key?("options")

    # create card
    card.save!
  end

  # return a hash of properties to assign to Card.new
  def default_details(card_info)
    card_template = CardTemplate.find_by(name: card_info["template"])

    return {
      instruction: card_info["instruction"],
      card_template:,
      model_answer: card_info["answer"]
    }
  end

  # if options is set as a key, loop through to create the options first
  # then return as an array of Options to assign to card.options
  def set_card_options
    card_info["options"].map { |option| Option.new(content: option) }
  end

  # helper method to set card context for the create_lesson_card() method
  def set_card_context(card, context)
    if context.instance_of?(String)
      card.context = context
    else
      # TODO: change hard coded files
      # file_path = File.join(Rails.root, "app", "assets", "audio", "sample_card_audio.mp3")

      filepath = File.open(context["source"])
      filename = filepath.split("/").last

      if context["type"] == "audio/mpeg"
        card.audio.attach(io: filepath, filename:, content_type: "audio/mpeg")
      elsif context[:type] == "image/png"
        card.picture.attach(io: filepath, filename:, content_type: "image/png")
      end
    end
  end
end
