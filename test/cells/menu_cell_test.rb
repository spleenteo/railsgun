require 'test_helper'

class MenuCellTest < Cell::TestCase
  test "first_level" do
    invoke :first_level
    assert_select "p"
  end
  

end
