require "application_system_test_case"

class CompetitionsTest < ApplicationSystemTestCase
  setup do
    @competition = competitions(:one)
  end

  test "visiting the index" do
    visit competitions_url
    assert_selector "h1", text: "Competitions"
  end

  test "should create competition" do
    visit competitions_url
    click_on "New competition"

    fill_in "Date", with: @competition.date
    fill_in "Name", with: @competition.name
    click_on "Create Competition"

    assert_text "Competition was successfully created"
    click_on "Back"
  end

  test "should update Competition" do
    visit competition_url(@competition)
    click_on "Edit this competition", match: :first

    fill_in "Date", with: @competition.date
    fill_in "Name", with: @competition.name
    click_on "Update Competition"

    assert_text "Competition was successfully updated"
    click_on "Back"
  end

  test "should destroy Competition" do
    visit competition_url(@competition)
    click_on "Destroy this competition", match: :first

    assert_text "Competition was successfully destroyed"
  end
end
