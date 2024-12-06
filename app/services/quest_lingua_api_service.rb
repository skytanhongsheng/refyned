class QuestLinguaApiService
  # -------------------------------------------
  # Card Generation
  # -------------------------------------------
  class CardGeneration
    def self.call(request)
      headers = {
        content_type: :json
      }

      res = RestClient.post("https://q68aemnb5sgph8-4000.proxy.runpod.net/card-generation", request,
                            headers) do |response|
        response.follow_redirection
      end

      JSON.parse(res)
    end
  end

  # -------------------------------------------
  # Similarity Comparison
  # -------------------------------------------
  class SimilarityComparison
    def self.call(request)
      headers = {
        content_type: :json
      }

      res = RestClient.post("http://34.143.209.64:8000/scoring-and-restructuring", JSON.generate(request),
                            headers) do |response|
        response.follow_redirection
      end

      JSON.parse(res)
    end
  end
end
