require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'

class ShipTest < Minitest::Test

  def setup
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Ship, @cruiser
  end

  def test_it_has_a_name
    assert_equal "Cruiser", @cruiser.name
  end

  def test_it_has_a_length
    assert_equal 3, @cruiser.length
  end

  def test_it_begins_with_3_health
    assert_equal 3, @cruiser.health
  end

  def test_it_begins_not_sunk
    refute @cruiser.sunk?
  end

  def test_a_hit_reduces_health_by_one
    @cruiser.hit
    assert_equal 2, @cruiser.health

    @cruiser.hit
    assert_equal 1, @cruiser.health
  end

  def test_three_hits_changes_sunk_to_true
    @cruiser.hit
    @cruiser.hit
    @cruiser.hit

    assert @cruiser.sunk?
  end

end
