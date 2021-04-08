require "test_helper"

class ViewcountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @viewcount = viewcounts(:one)
  end

  test "should get index" do
    get viewcounts_url
    assert_response :success
  end

  test "should get new" do
    get new_viewcount_url
    assert_response :success
  end

  test "should create viewcount" do
    assert_difference('Viewcount.count') do
      post viewcounts_url, params: { viewcount: { created_at: @viewcount.created_at, stream_id: @viewcount.stream_id, viewers: @viewcount.viewers } }
    end

    assert_redirected_to viewcount_url(Viewcount.last)
  end

  test "should show viewcount" do
    get viewcount_url(@viewcount)
    assert_response :success
  end

  test "should get edit" do
    get edit_viewcount_url(@viewcount)
    assert_response :success
  end

  test "should update viewcount" do
    patch viewcount_url(@viewcount), params: { viewcount: { created_at: @viewcount.created_at, stream_id: @viewcount.stream_id, viewers: @viewcount.viewers } }
    assert_redirected_to viewcount_url(@viewcount)
  end

  test "should destroy viewcount" do
    assert_difference('Viewcount.count', -1) do
      delete viewcount_url(@viewcount)
    end

    assert_redirected_to viewcounts_url
  end
end
