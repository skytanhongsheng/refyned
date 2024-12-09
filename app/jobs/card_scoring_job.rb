class CardScoringJob < ApplicationJob
  queue_as :default

  def perform(id, user_answer, model_answer)
    @card = Card.find(id)
    req_body = {
      id:,
      user_text: user_answer,
      model_answer:
    }
    response = QuestLinguaApiService::SimilarityComparison.call(req_body)
    @card.correct = response["score"] > 0.7
    @card.save

    @card.broadcast_score
  end
end
