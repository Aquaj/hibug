require 'minitest/autorun'
require_relative '../lib/matryochka.rb'

class MatryochkaTest < Minitest::Test
  def test_method_can_get_the_binding_of_their_parent
    test = :hello
    fetched_binding = get_binding
    assert_equal fetched_binding.local_variable_get(:test),
                 binding.local_variable_get(:test)
  end

  def test_a_method_can_get_the_binding_of_higher_up_ancestors
    test = :hello
    fetched_binding = parent_method(levels: 2)
    assert_equal fetched_binding.local_variable_get(:test),
                 binding.local_variable_get(:test)
  end

  def test_returning_nil_if_frame_doesnt_exist
    assert_nil Matryochka.get_binding(up: 5_000_000) # Sure, you never know, but I feel pretty safe
  end

  private

  def get_binding(levels: 1)
    Matryochka.get_binding(up: levels)
  end

  def parent_method(*args, **kwargs)
    test = :bonjour
    get_binding(*args, **kwargs)
  end
end
