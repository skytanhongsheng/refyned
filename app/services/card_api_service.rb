class CardApiService
  # this class will handle the fetching of the schedule
  class Schedule
    def initialize(curriculum)
      @curriculum = curriculum
    end

    def fetch_lesson_plan
      { schedule: [
        {
          title: 'Learn basics',
          description: 'Learn the basic grammer and vocab of the language'
        },
        {
          title: 'Greetings',
          description: 'Learn how to say hello and goodbye'
        }
      ] }
    end
  end

  # this class will control all the api calls to
  # the picture endpoint.
  class Picture
    class << self
      def fetch_new
      end
    end
  end
end
