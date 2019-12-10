require 'minitest/autorun'
require 'minitest/pride'
require './lib/ship'
require './lib/cell'

class CellTest < Minitest::Test

  def setup
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end

  def test_it_exists
    assert_instance_of Cell, @cell
  end

  def test_it_has_attributes
    assert_equal "B4", @cell.coordinate
    assert_nil @cell.ship
    refute @cell.fired_upon
  end

  def test_it_begins_empty
    assert @cell.empty?
  end

  def test_place_ship_occupies_cell
    @cell.place_ship(@cruiser)

    assert_equal @cruiser, @cell.ship
    refute @cell.empty?
  end

  def test_it_is_not_fired_upon_initially
    refute @cell.fired_upon?
  end

  def test_it_can_fire_upon_empty_cell
    @cell.fire_upon

    assert_equal 3, @cruiser.health
    assert @cell.fired_upon?
  end

  def test_it_can_fire_on_occupied_cell_and_decrease_health
    @cell.place_ship(@cruiser)
    @cell.fire_upon

    assert_equal 2, @cruiser.health
    assert @cell.fired_upon?
  end

  def test_it_renders_properly_while_empty
    assert_equal ".", @cell.render
    @cell.fire_upon

    assert_equal "M", @cell.render
  end

  def test_it_can_render_ship_properly_with_optional_boolean_argument
    @cell.place_ship(@cruiser)

    assert_equal "S", @cell.render(true)
  end

  def test_it_renders_properly_after_hit_ship
    @cell.place_ship(@cruiser)
    @cell.fire_upon

    assert_equal "H", @cell.render
  end

  def test_it_renders_properly_when_ship_is_sunk
    @cell.place_ship(@cruiser)
    @cell.fire_upon

    assert_equal "H", @cell.render
    assert_equal false, @cruiser.sunk?

    @cruiser.hit
    @cruiser.hit

    assert_equal true, @cruiser.sunk?
    assert_equal "X", @cell.render
  end

end
