class CardScoringJob < ApplicationJob
  queue_as :default

  def perform(id, user_answer, model_answer)
    @card = Card.find(id)
    @card.correct = AnswerSimilarityService.is_correct?(id, user_answer, model_answer)
    @card.save
  end
end
