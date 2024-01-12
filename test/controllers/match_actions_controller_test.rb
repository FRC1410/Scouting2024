require "test_helper"

class MatchActionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @match_action = match_actions(:one)
  end

  test "should get index" do
    get match_actions_url
    assert_response :success
  end

  test "should get new" do
    get new_match_action_url
    assert_response :success
  end

  test "should create match_action" do
    assert_difference("MatchAction.count") do
      post match_actions_url, params: { match_action: { action_id: @match_action.action_id, match_id: @match_action.match_id, score: @match_action.score, team_id: @match_action.team_id } }
    end

    assert_redirected_to match_action_url(MatchAction.last)
  end

  test "should show match_action" do
    get match_action_url(@match_action)
    assert_response :success
  end

  test "should get edit" do
    get edit_match_action_url(@match_action)
    assert_response :success
  end

  test "should update match_action" do
    patch match_action_url(@match_action), params: { match_action: { action_id: @match_action.action_id, match_id: @match_action.match_id, score: @match_action.score, team_id: @match_action.team_id } }
    assert_redirected_to match_action_url(@match_action)
  end

  test "should destroy match_action" do
    assert_difference("MatchAction.count", -1) do
      delete match_action_url(@match_action)
    end

    assert_redirected_to match_actions_url
  end
end
