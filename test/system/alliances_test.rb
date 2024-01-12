require "application_system_test_case"

class AlliancesTest < ApplicationSystemTestCase
  setup do
    @alliance = alliances(:one)
  end

  test "visiting the index" do
    visit alliances_url
    assert_selector "h1", text: "Alliances"
  end

  test "should create alliance" do
    visit alliances_url
    click_on "New alliance"

    fill_in "Competition", with: @alliance.competition_id
    fill_in "Name", with: @alliance.name
    click_on "Create Alliance"

    assert_text "Alliance was successfully created"
    click_on "Back"
  end

  test "should update Alliance" do
    visit alliance_url(@alliance)
    click_on "Edit this alliance", match: :first

    fill_in "Competition", with: @alliance.competition_id
    fill_in "Name", with: @alliance.name
    click_on "Update Alliance"

    assert_text "Alliance was successfully updated"
    click_on "Back"
  end

  test "should destroy Alliance" do
    visit alliance_url(@alliance)
    click_on "Destroy this alliance", match: :first

    assert_text "Alliance was successfully destroyed"
  end
end
