require 'minitest/autorun'

class OddTest < Minitest::Test
  def test_odd?
    value = 3
    assert(value.odd?, 'value is not odd')
  end

  def test_xyz
    value = 'xyz'
    assert_equal('xyz', value.downcase)
  end

  def test_nil
    value = nil
    assert_nil value
  end

  def test_empty
    array = []
    assert_empty array
  end

  def test_include
    value = 'xyz'
    list = ['xyz']
    assert_includes list, value
  end

  def test_no_experience_error
    skip
    assert_raises NoExperienceError do
      employee.hire
    end
  end

  def test_instance_of
    value = 1.0
    assert_instance_of Numeric, value
  end

  def test_kind_of
    value = 1
    assert_kind_of Numeric, value
  end

  def test_different_objects
    skip
    list = []
    assert_same(list, list.process)
  end

  def test_not_include
    list = []
    refute_includes(list, 'xyz')
  end
end