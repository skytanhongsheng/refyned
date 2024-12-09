class CreateCurriculumLessonsService
  def initialize(curriculum)
    @curriculum = curriculum
  end

  # Make API call to get array of curriculum lesson data
  # { title: string, description: string}[]
  def generate_lessons_info
    send_request(request_body)
  end

  private

  # build request body
  def request_body
    {
      language: @curriculum.language.name,
      purpose: @curriculum.purpose,
      context: @curriculum.context,
      n_days: (@curriculum.end_date - @curriculum.start_date).to_i
    }
  end

  # send request to API endpoint
  # def send_mock_request(request_body)
  #   lessons_file_path = File.join(Rails.root, 'db', 'data', 'lesson_plan.yml')
  #   lessons_info = YAML.load(File.open(lessons_file_path))
  #   lessons_info.first(2)
  # end

  # send request to API endpoint
  def send_request(request_body)
    QuestLinguaApiService::LessonGeneration.call(request_body)
  end
end
