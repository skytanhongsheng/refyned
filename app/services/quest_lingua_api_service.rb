class QuestLinguaApiService
  # Base method to handle API calls with redirect handling
  def self.make_request(url, request, headers)
    begin
      res = RestClient.post(url, JSON.generate(request), headers)
    rescue RestClient::TemporaryRedirect => e
      redirected_url = e.response.headers[:location]
      res = RestClient.post(redirected_url, JSON.generate(request), headers)
    end
    res
  end

  # -------------------------------------------
  # Lesson Generation
  # -------------------------------------------
  class LessonGeneration
    API_URL = "https://zc75at5z6z49uz-8888.proxy.runpod.net/lesson-plan-generation/"

    def self.call(request)
      # return mock_response

      headers = { content_type: :json }
      res = QuestLinguaApiService.make_request(API_URL, request, headers)
      JSON.parse(res.body)
    end
  end

  # -------------------------------------------
  # Card Generation
  # -------------------------------------------
  class CardGeneration
    API_URL = "https://zc75at5z6z49uz-8888.proxy.runpod.net/card-generation/"

    def self.call(request)
      # return mock_response

      headers = { content_type: :json }
      res = QuestLinguaApiService.make_request(API_URL, request, headers)
      JSON.parse(res.body)
    end

    def self.mock_response
      [{ "instruction" => "Describe the image below:",
         "template" => "Picture Comprehension",
         "context" => { "type" => "image/png",
                        "source" => "https://storage.googleapis.com/gcs-images-for-proj/generated_images/5801ac01-253d-4478-b166-6d0757b4f6c1.png" },
         "options" => nil,
         "answer" => "有两个女人在黑板上写着中国字的中国字" },
       { "instruction" => "Describe the image below:",
         "template" => "Picture Comprehension",
         "context" => { "type" => "image/png",
                        "source" => "https://storage.googleapis.com/gcs-images-for-proj/generated_images/595c4c08-bc02-473d-ba44-bb38d2435455.png" },
         "options" => nil,
         "answer" => "穿黄色衬衫、背着紫色背背包的穿黄色衬衫的女孩在镜头中微笑" },
       { "instruction" => "To say \"hello\" in Mandarin, you would say _____.",
         "template" => "mcq",
         "context" => "To say \"hello\" in Mandarin, you would say ____.",
         "options" => ["谢谢 - xièxiè", "对不起 - duìbuqǐ", "你好 - nǐ hǎo", "再见 - zàijiàn"],
         "answer" => "你好 - nǐ hǎo" },
       { "instruction" => "If you want to ask someone how they are in Mandarin, you can say 你好吗, which means _____.",
         "template" => "mcq",
         "context" => "If you want to ask someone how they are in Mandarin, you can say 你好吗, which means ____.",
         "options" => ["Goodbye", "How are you", "Thank you", "Hello"],
         "answer" => "How are you" },
       { "instruction" => "When someone thanks you in Mandarin, you can respond with 不客气 - bù kèqì, which means _____.",
         "template" => "mcq",
         "context" => "When someone thanks you in Mandarin, you can respond with 不客气 - bù kèqì, which means ____.",
         "options" => ["Goodbye", "Hello", "You're welcome", "Sorry"],
         "answer" => "You're welcome" },
       { "instruction" => "The Mandarin phrase for \"thank you\" is _____.",
         "template" => "mcq",
         "context" => "The Mandarin phrase for \"thank you\" is ____.",
         "options" => ["谢谢 - xièxiè", "你好 - nǐ hǎo", "请问 - qǐngwèn", "再见 - zàijiàn"],
         "answer" => "谢谢 - xièxiè" },
       { "instruction" => "Translate the Mandarin phrase 请问 to English: _____.",
         "template" => "mcq",
         "context" => "Translate the Mandarin phrase 请问 to English: ____.",
         "options" => ["Goodbye", "Excuse me", "Hello", "Sorry"],
         "answer" => "Excuse me" },
       { "instruction" => "If you hear the phrase 再见 - zàijiàn, you know the person is saying _____.",
         "template" => "mcq",
         "context" => "If you hear the phrase 再见 - zàijiàn, you know the person is saying ____.",
         "options" => ["Hello", "Thank you", "Goodbye", "Sorry"],
         "answer" => "Goodbye" }]
    end
  end

  # -------------------------------------------
  # Similarity Comparison
  # -------------------------------------------
  class SimilarityComparison
    API_URL = "http://34.143.209.64:8000/scoring-and-restructuring/"

    def self.call(request)
      headers = { content_type: :json }
      res = QuestLinguaApiService.make_request(API_URL, request, headers)
      JSON.parse(res)
    end
  end
end
