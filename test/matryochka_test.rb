require 'minitest/autorun'
require_relative '../lib/matryochka.rb'

class MatryochkaTest < Minitest::Test
  def test_method_can_get_the_binding_of_their_parent
    fetched_binding = get_binding
    assert_equal fetched_binding, binding
  end

  def test_a_method_can_get_the_binding_of_higher_up_ancestors
    fetched_binding = parent_method(levels: 2)
    assert_equal fetched_binding, binding
  end

  private

  def get_binding(levels: 1)
    Matryochka.get_binding(up: levels)
  end

  def parent_method(*args, **kwargs)
    get_binding(*args, **kwargs)
  end
end
