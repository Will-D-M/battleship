require_relative 'player'

class Game

  attr_accessor :computer, :user

  def initialize
    @computer = nil
    @user = nil
  end

  def welcome
    puts "Welcome to BATTLESHIP \n\n"
  end

  def start_game
    puts "Enter p to play. Enter q to quit. \n\n"
    print "> "
    menu_selection = gets.chomp.downcase

    until menu_selection == "p" || menu_selection == "q"
      puts "\nPlease enter a valid selection"
      print "> "
      menu_selection = gets.chomp.downcase
    end

    if menu_selection == "p"
      computer_setup
    else
      return
    end
  end

  def computer_setup
    puts "\n\n...game loading...\n\n"
    puts "Computer is placing ships on their grid...\n\n"

    @computer = Player.new
    @computer.create_computer_board
    @computer.create_computer_ships
    @computer.place_computer_ships

    user_setup
  end

  def user_setup
    puts "The computer's ships are on the grid.\n\n"
    puts "Now it's your turn.\n\n"

    @user = Player.new
    @user.create_user_board
    @user.create_user_ships

    puts "Your Cruiser is three units long.\n"
    puts "For example:\n\nA1 A2 A3\nor\nA1 B1 C1\n\n"

    puts @user.user_board.render

    @user.place_user_ships

    user_shot_input
  end

  def render_boards
    puts "\n==========CURRENT COMPUTER BOARD=========="
    puts @computer.computer_board.render
    puts "\n===========CURRENT USER BOARD==========="
    puts @user.user_board.render(true)
  end

  def user_shot_input
    render_boards

    puts "\nEnter the coordinate for your shot:"
    print "> "

    user_shot_coordinate = gets.chomp.upcase
    user_shot_validation(user_shot_coordinate)
  end

  def user_shot_validation(user_shot_coordinate)
    until @computer.computer_board.valid_coordinate?(user_shot_coordinate) && !@computer.computer_board.cells[user_shot_coordinate].fired_upon?

      if !@computer.computer_board.valid_coordinate?(user_shot_coordinate)
        puts "\nYou entered an invalid coordinate."
        user_shot_input
      else @computer.computer_board.cells[user_shot_coordinate].fired_upon?
        puts "\nYou have already fired upon this cell. Please enter a new coordinate:"
        print "> "
        user_shot_input
      end

    end
    puts "\nFiring your missile..."
    user_shot_feedback(user_shot_coordinate)
  end

  def user_shot_feedback(user_shot_coordinate)
    @computer.computer_board.cells[user_shot_coordinate].fire_upon
    if @computer.computer_board.cells[user_shot_coordinate].render == "M"
      result = "miss."
    elsif @computer.computer_board.cells[user_shot_coordinate].render == "H"
      result = "hit!"
    elsif @computer.computer_board.cells[user_shot_coordinate].render == "X"
      result = "hit and sunk my #{@computer.computer_board.cells[user_shot_coordinate].ship.name}!"
    end

    puts "\nYour shot on #{user_shot_coordinate} was a #{result}\n\n"

    all_computer_ships_sunk
  end

  def all_computer_ships_sunk
    if @computer.computer_ships.all? { |ship| ship.sunk? }
      puts "You win!\n\n"
      puts "Would you like to play again?\n\n"
      main_menu
    else
      create_computer_turn
    end
  end

  def create_computer_turn
    puts "Firing my missile..."
    @user.computer_takes_shot
    all_user_ships_sunk
  end

  def all_user_ships_sunk
    if @user.user_ships.all? { |ship| ship.sunk? }
      puts "You lose!\n\n"
      puts "Would you like to play again?\n\n"
      start_game
    else
      user_shot_input
    end
  end

  def end_game
    puts "\nGoodbye.\n\n"
  end

end
