require "application_system_test_case"

class ViewcountsTest < ApplicationSystemTestCase
  setup do
    @viewcount = viewcounts(:one)
  end

  test "visiting the index" do
    visit viewcounts_url
    assert_selector "h1", text: "Viewcounts"
  end

  test "creating a Viewcount" do
    visit viewcounts_url
    click_on "New Viewcount"

    fill_in "Created at", with: @viewcount.created_at
    fill_in "Stream", with: @viewcount.stream_id
    fill_in "Viewers", with: @viewcount.viewers
    click_on "Create Viewcount"

    assert_text "Viewcount was successfully created"
    click_on "Back"
  end

  test "updating a Viewcount" do
    visit viewcounts_url
    click_on "Edit", match: :first

    fill_in "Created at", with: @viewcount.created_at
    fill_in "Stream", with: @viewcount.stream_id
    fill_in "Viewers", with: @viewcount.viewers
    click_on "Update Viewcount"

    assert_text "Viewcount was successfully updated"
    click_on "Back"
  end

  test "destroying a Viewcount" do
    visit viewcounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Viewcount was successfully destroyed"
  end
end
