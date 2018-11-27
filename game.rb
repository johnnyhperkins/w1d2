require_relative 'board'
require 'byebug'

class Game
  attr_reader :grid_size
  attr_accessor :previous_guess, :alert_message
  def initialize(grid_size)
    @grid_size = grid_size
    @board = Board.new(grid_size)
    @previous_guess = []
    @alert_message = ''
  end
  def get_guess
    puts "Hey, make a guess dingus (i.e. row, col)"
    guess = gets.chomp
    numbers = "1234567890"
    selected = guess.split("").select { |num| numbers.include?(num) }
    selected.map! { |num| num.to_i }
  end
  def play
    until @board.won?
      #  sleep(2)
      system("clear")
      @board.render
      puts self.alert_message
     
      # debugger
      guess = get_guess
      
      if valid_guess?(guess)
        flip_card(guess)
        #  if first guess...
        if self.previous_guess.empty? 
          self.previous_guess = guess 
        # if it's second guess and a match
        elsif @board[guess].to_s == @board[self.previous_guess].to_s
          self.alert_message = "It's a match!\n"
          self.previous_guess = []
          break if @board.won?  
        # if it's not a match 
        else
          self.alert_message = "WRONG"
          @board[guess].hide
          @board[self.previous_guess].hide
          self.previous_guess = []
        end
      else
        self.alert_message = "Invalid guess, try again"
      end
    end
    system('clear')
    puts "Great fucking job"
    @board.render
  end
  def valid_guess?(guess)
    (!guess.any? {|n| n > self.grid_size - 1 } ||
    !@board[guess].face_up || 
    !self.previous_guess == guess)
  end
  def flip_card(guess)
    @board.reveal(guess)
  end
end

game = Game.new(2)
game.play