require "test_helper"

class Minicap::Test < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Minicap::VERSION
  end
end
