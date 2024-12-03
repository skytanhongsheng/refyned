class CreateLessonCardsService
  def generate_cards_info(lesson)
    send_request(request_body(lesson))
  end

  private

  # build request body
  def request_body(lesson)
    {
      title: lesson.title,
      description: lesson.description,
      card_count: calculate_card_count(
        lesson.curriculum.lesson_hours,
        lesson.curriculum.templates
      )
    }
  end

  # send request to API endpoint
  def send_request(request_body)
    # TODO: replace hard coded cards below with
    cards_file_path = File.join(Rails.root, 'db', 'data', 'cards.json')
    cards_json_content = File.read(cards_file_path)
    JSON.parse(cards_json_content, { symbolize_names: true })
  end

  # calculate the card count ber template for the request body
  def calculate_card_count(lesson_hours, card_templates)
    total_card_count = 0
    if lesson_hours >= 6 then total_card_count = 50
    elsif lesson_hours >= 2 then total_card_count = 25
    elsif lesson_hours > 1 then total_card_count = 20
    else
      total_card_count = 10
    end
    count_per_template = (total_card_count.to_f / card_templates.length).round

    card_count = {}
    card_templates.each do |template|
      card_count[template.name.strip.downcase.gsub(/\s+/, '_')] = count_per_template
    end
    card_count
  end
end
