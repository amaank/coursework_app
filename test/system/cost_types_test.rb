require "application_system_test_case"

class CostTypesTest < ApplicationSystemTestCase

  test "visiting the index" do
    visit cost_types_url
    assert_selector "h1", text: "Cost Types"
  end

end
