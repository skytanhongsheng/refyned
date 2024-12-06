class CreateLessonCardsService
  def initialize(lesson)
    @lesson = lesson
  end

  def generate_cards_info
    send_request(request_body)
  end

  private

  # build request body
  def request_body
    {
      title: @lesson.title,
      description: @lesson.description,
      card_count: @lesson.curriculum.card_counts
    }
  end

  # send request to API endpoint
  def send_request(request_body)
    # TODO: replace hard coded cards below with
    # cards_file_path = File.join(Rails.root, 'db', 'data', 'cards.json')
    # cards_json_content = File.read(cards_file_path)
    # JSON.parse(cards_json_content, { symbolize_names: true })
    open_ai = OpenAIService.new

    base_cards = QuestLinguaApiService::CardGeneration.call(request_body)
    audio_cards = open_ai.generate_audio_cards(request_body)

    base_cards.merge(audio_cards)
  end
end
