class CreateLessonCardsService
  def initialize(lesson)
    @client = OpenAI::Client.new
    @lesson = lesson
  end

  def generate_cards_info
    send_request(request_body)
  end

  def generate_audio_card
    response = @client.audio.speech(
      parameters: {
        model: "tts-1",
        input: "今天天气真好",
        voice: "alloy",
        response_format: "mp3", # Optional
        speed: 1.0
      }
    )
    File.binwrite(Rails.root.join('tmp', 'test.mp3'), response)
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
  end
end
