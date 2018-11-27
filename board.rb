require_relative 'card'
require 'byebug'

class Board
  attr_accessor :grid
  attr_reader :size
  def initialize(size)
    @size = size
    @grid = []
    populate
  end
  def populate
    # debugger
    cards = []
    num_card_pairs = (size * size)/2
    num_card_pairs.times do |i|
      cards << Array.new(2) {Card.new(i)}
    end
    cards = cards.flatten.shuffle
    cards.each_index do |idx|
      self.grid << cards[idx...idx + self.size] if idx % self.size == 0
    end
  end
  def render
    self.grid.each_with_index do |row,idx|
      row.each do |card|
        if card.face_up 
          print " _#{card.to_s}_ " 
        else
          print " ____ "
        end
      end

      print "\n\n"
    end
    nil
  end

  def won?
    self.grid.flatten.all? { |card| card.face_up }
  end

  def reveal(guessed_pos)
    self[guessed_pos].reveal unless self[guessed_pos].face_up
  end

  def [](pos)
    row, col = pos
    self.grid[row][col]
  end

  def []=(pos)
    row, col = pos
    self.grid[row][col]
  end

end

