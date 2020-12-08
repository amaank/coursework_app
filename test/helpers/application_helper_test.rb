class ApplicationHelperTest < ActionView::TestCase
  test "should return appropriate Bootstrap class for given flash key" do
    assert_equal "alert alert-success", flash_class("notice")
    assert_equal "alert alert-danger", flash_class("alert")
  end
end
