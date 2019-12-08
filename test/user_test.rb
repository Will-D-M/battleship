require 'minitest/autorun'
require 'minitest/pride'
require './lib/user'
require './lib/board'
require './lib/game'
class UserTest < MiniTest::Test

    def setup
      @player = User.new
      @computer = User.new(false)
    end

    def test_user_exists
      assert_instance_of User, @player
      assert_instance_of User, @computer
    end
end
