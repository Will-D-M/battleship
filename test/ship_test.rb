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

  def test_it_has_attributes
    assert_equal "Cruiser", @cruiser.name
    assert_equal 3, @cruiser.length
    assert_equal 3, @cruiser.health
    refute @cruiser.sunk
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
    refute @cruiser.sunk?

    @cruiser.hit
    @cruiser.hit

    assert @cruiser.sunk?
  end

end
