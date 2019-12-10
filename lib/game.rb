require_relative 'player'

class Game

  attr_accessor :computer_player, :user_player


  def initialize
    @computer_player = nil
    @user_player = nil
  end


  def welcome
    puts "Welcome to BATTLESHIP \n\n"
  end


  def main_menu
    puts "Enter p to play. Enter q to quit. \n\n"
    print "> "
    menu_selection = gets.chomp.downcase

    until menu_selection == "p" || menu_selection == "q"
      puts "\nPlease enter a valid selection"
      print "> "
      menu_selection = gets.chomp.downcase
    end

    if menu_selection == "q"
      puts "\nGoodbye.\n\n"
      return
    else
      computer_setup
    end
  end


  def computer_setup
    puts "\n\n...game loading...\n\n"
    puts "Computer is placing ships on their grid...\n\n"

    @computer_player = Player.new
    @computer_player.create_computer_player_board
    @computer_player.create_computer_player_ships
    @computer_player.place_computer_player_ships

    user_setup
  end


  def user_setup
    puts "The computer's ships are on the grid.\n\n"
    puts "Now it's your turn.\n\n"

    @user_player = Player.new
    @user_player.create_user_player_board
    @user_player.create_user_player_ships

    puts "Your Cruiser is three units long.\n"
    puts "For example:\n\nA1 A2 A3\nor\nA1 B1 C1\n\n"

    @user_player.place_user_player_ships

    puts @user_player.user_board.render

    user_turn
  end


  def render_boards
    puts "\n==========CURRENT COMPUTER BOARD=========="
    puts @computer_player.computer_board.render
    puts "\n===========CURRENT USER BOARD==========="
    puts @user_player.user_board.render(true)
  end


  def user_turn
    render_boards

    puts "\nEnter the coordinate for your shot:"
    print "> "

    user_shot_coordinate = gets.chomp.upcase

    # recursion, will require argument
    until @computer_player.computer_board.valid_coordinate?(user_shot_coordinate) && !@computer_player.computer_board.cells[user_shot_coordinate].fired_upon?

      if !@computer_player.computer_board.valid_coordinate?(user_shot_coordinate)
        puts "\nPlease enter a valid coordinate:"
        print "> "
        user_shot_coordinate = gets.chomp.upcase
      else @computer_player.computer_board.cells[user_shot_coordinate].fired_upon?
        puts "\nYou have already fired upon this cell. Please enter a new coordinate:"
        print "> "
        user_shot_coordinate = gets.chomp.upcase
      end

      user_shot_coordinate
    end

    puts "\nFiring your missile..."

    @computer_player.computer_board.cells[user_shot_coordinate].fire_upon
    if @computer_player.computer_board.cells[user_shot_coordinate].render == "M"
      result = "miss."
    elsif @computer_player.computer_board.cells[user_shot_coordinate].render == "H"
      result = "hit!"
    elsif @computer_player.computer_board.cells[user_shot_coordinate].render == "X"
      result = "hit and sunk my #{@computer_player.computer_board.cells[user_shot_coordinate].ship.name}!"
    end

    puts "\nYour shot on #{user_shot_coordinate} was a #{result}\n\n"

    all_computer_ships_sunk
  end


  def all_computer_ships_sunk
    if @computer_player.computer_ships.all? { |ship| ship.sunk? }
      puts "You win!\n\n"
      puts "Would you like to play again?\n\n"
      main_menu
    else
      computer_turn
    end
  end


  def computer_turn
    puts "Firing my missile..."
    @user_player.computer_takes_shot
    all_user_ships_sunk
  end


  def all_user_ships_sunk
    if @user_player.user_ships.all? { |ship| ship.sunk? }
      puts "You lose!\n\n"
      puts "Would you like to play again?\n\n"
      main_menu
    else
      user_turn
    end
  end


end
