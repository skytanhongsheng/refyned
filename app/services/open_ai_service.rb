class OpenAiService
  def initialize
    @client = OpenAI::Client.new
  end

  # generate the cards for the audio
  # craete the audio files based on the inputs generated
  # save to tmp folder and send back as json for card creation
  def generate_audio_cards(request)
    return if request["card_count"]["listening_comprehension"].zero?

    inputs = create_inputs(request)
    response = []

    inputs.each do |input|
      response = @client.audio.speech(
        parameters: {
          model: "tts-1",
          input: input,
          voice: "alloy",
          response_format: "mp3",
          speed: 1.0
        }
      )
      filename = "#{DateTime.now.strftime('%Q').to_i}.mp3"
      filepath = Rails.root.join('tmp', filename)
      File.binwrite(filepath, response)

      response << {
        instruction: "Type what you hear below:",
        template: "Listening Comprehension",
        context: {
          type: "audio/mpeg",
          source: filepath
        },
        answer: input
      }
    end
  end

  # this doesn't generate the audio but rather just
  # the phrases that we need to convert into audio
  def create_inputs(request)
    res = @client.chat(
      parameters: {
        model: "gpt-4o",
        response_format: { type: "json_object" },
        messages: [{ role: "user", content: make_prompt(request) }],
        temperature: 0.7
      }
    )

    JSON.parse res["choices"][0]["message"]["content"]
  end

  # create the prompt based on the request
  def make_prompt(request)
    card_count = request["card_count"]["listening_comprehension"]
    title = request["title"]
    description = request["description"]

    <<~PROMPT
      Create #{card_count} phrases of no more than 10 words for a lesson in simplified mandarin.
      The lesson is titled `#{title}`, and the objective: #{description}
      The aim is for a learner to be able to transcribe what is being said so the phrase should be simple.
      Do not use any placeholders or english in your response.
      Return a json response in the format:
      {
        "phrases": ["phrase1", "phrase2"]
      }
    PROMPT
  end
end
