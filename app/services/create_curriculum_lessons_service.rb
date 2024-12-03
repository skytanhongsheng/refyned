class CreateCurriculumLessonsService
  # Make API call to get array of curriculum lesson data
  # { title: string, description: string}[]
  def generate_lessons_info(curriculum)
    send_request(request_body(curriculum))
  end

  private

  # build request body
  def request_body(curriculum)
    {
      title: curriculum.title,
      purpose: curriculum.purpose,
      context: curriculum.context,
      duration: curriculum.end_date - curriculum.start_date
    }
  end

  # send request to API endpoint
  def send_request(request_body)
    # TODO: replace the following hard coded data with API request
    lessons_file_path = File.join(Rails.root, 'db', 'data', 'lesson_plan.yml')
    lessons_info = YAML.load(File.open(lessons_file_path))
    lessons_info.first(2)
  end
end
