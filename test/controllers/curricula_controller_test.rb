require "test_helper"

class CurriculaControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get curricula_show_url
    assert_response :success
  end
  # test "the truth" do
  #   assert true
  # end
end
