require "application_system_test_case"

class MatchActionsTest < ApplicationSystemTestCase
  setup do
    @match_action = match_actions(:one)
  end

  test "visiting the index" do
    visit match_actions_url
    assert_selector "h1", text: "Match actions"
  end

  test "should create match action" do
    visit match_actions_url
    click_on "New match action"

    fill_in "Action", with: @match_action.action_id
    fill_in "Match", with: @match_action.match_id
    fill_in "Score", with: @match_action.score
    fill_in "Team", with: @match_action.team_id
    click_on "Create Match action"

    assert_text "Match action was successfully created"
    click_on "Back"
  end

  test "should update Match action" do
    visit match_action_url(@match_action)
    click_on "Edit this match action", match: :first

    fill_in "Action", with: @match_action.action_id
    fill_in "Match", with: @match_action.match_id
    fill_in "Score", with: @match_action.score
    fill_in "Team", with: @match_action.team_id
    click_on "Update Match action"

    assert_text "Match action was successfully updated"
    click_on "Back"
  end

  test "should destroy Match action" do
    visit match_action_url(@match_action)
    click_on "Destroy this match action", match: :first

    assert_text "Match action was successfully destroyed"
  end
end
