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
    card = Card.new(default_details(card_info))           # assign general details
    card.lesson = lesson                                  # assign the lesson
    card = set_card_context(card, card_info["context"])   # set context to appropriate columns accordingly
    card.options = card_options(card_info)                # check and add options
    card.save!                                            # create card
  end

  # return a hash of properties to assign to Card.new
  def default_details(card_info)
    name = card_info["template"] == "mcq" ? "MCQ" : card_info["template"] # hardfix now for mcq == MCQ
    card_template = CardTemplate.find_by(name:)

    return {
      instruction: card_info["instruction"],
      card_template:,
      model_answer: card_info["answer"]
    }
  end

  # if options is set as a key, loop through to create the options first
  # then return as an array of Options to assign to card.options
  def card_options(card_info)
    return [] if card_info["options"].nil?

    card_info["options"].map { |option| Option.new(content: option) }
  end

  # based on the type of card_template, card might require either
  # a simple string stored in `context`, or active storage
  # attachments for audio or picture.
  def set_card_context(card, context)
    # @Chris: could just check for nil? or exists?. less expensive than instance_of?
    if context.instance_of?(String)
      card.context = context
    else
      # TODO: change hard coded files
      # file_path = File.join(Rails.root, "app", "assets", "audio", "sample_card_audio.mp3")

      if File.exist? context["source"]
        filepath = File.open(context["source"])
      else
        res = Faraday.get(context["source"])
        filepath = StringIO.new(res.body)
      end

      if context["type"] == "audio/mpeg"
        filename = "#{rand(1_000_000)}-audio.mp3"
        card.audio.attach(io: filepath, filename:, content_type: "audio/mpeg")
      elsif context["type"] == "image/png"
        filename = "#{rand(1_000_000)}-image.png"
        card.picture.attach(io: filepath, filename:, content_type: "image/png")
      end
    end

    # return card to continue chaining
    card
  end
end
