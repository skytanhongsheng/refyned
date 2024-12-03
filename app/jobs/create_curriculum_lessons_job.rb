class CreateCurriculumLessonsJob < ApplicationJob
  queue_as :default

  def perform(curriculum)
    puts "running"
    # get lessons info from API service
    lessons_info = CreateCurriculumLessonsService.new.generate_lessons_info(curriculum)

    puts "Creating Lessons"
    # create lessons from lessons info
    lessons_info.each do |lesson_info|
      lesson = create_lesson(curriculum, lesson_info)
      CreateLessonCardsJob.perform_later(lesson)
    end
  end

  private

  #  create a lesson from lesson data
  def create_lesson(curriculum, lesson_info)
    Lesson.create!(
      title: lesson_info["title"],
      description: lesson_info["description"],
      curriculum: curriculum,
      score: 0,
      progress: 0
    )
  end
end
