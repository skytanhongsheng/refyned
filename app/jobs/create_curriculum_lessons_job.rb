class CreateCurriculumLessonsJob < ApplicationJob
  queue_as :default

  def perform(curriculum)
    # get lessons info from API service
    lessons_info = CreateCurriculumLessonsService.new(curriculum).generate_lessons_info

    puts "Creating Lessons"
    # create lessons from lessons info
    lessons_info.each_with_index do |lesson_info, i|
      lesson = create_lesson(curriculum, lesson_info, i + 1)
      CreateLessonCardsJob.perform_later(lesson)
    end
  end

  private

  #  create a lesson from lesson data
  def create_lesson(curriculum, lesson_info, order)
    Lesson.create!(
      title: lesson_info["title"],
      description: lesson_info["description"],
      curriculum: curriculum,
      order: order
    )
  end
end
