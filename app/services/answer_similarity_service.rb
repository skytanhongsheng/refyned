class AnswerSimilarityService
  PASSING_SCORE = 0.7

  def self.is_correct?(id, user_answer, model_answer)
    response = call_api(id, model_answer, user_answer)

    response[:score] >= PASSING_SCORE
  end

  def self.call_api(id, model_answer, user_answer)
    {
      score: 0.8
    }
  end
end
