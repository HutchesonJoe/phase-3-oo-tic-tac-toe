require 'pry'

class TicTacToe

  attr_accessor :token

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  def initialize(board = [" ", " "," "," "," "," "," "," "," "])
    @board = board
    @x_sqrs = []
    @o_sqrs = []
  end

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(choice)
    @choice = choice.to_i - 1
    # binding.pry
  end

  def move (sq, token = "X")
    @board[sq] = token
    @token = token
  end

  def position_taken?(i)
    @board[i] == "X" || @board[i] == "O" ? true : false
  end

  def valid_move?(i)
   if position_taken?(i) 
    false
   elsif i < 0
    false
   elsif i > 8
    false
   else true
   end
  end

  def turn_count
    count = 0
    @board.each do |sq| 
      if sq != " " 
        count+=1
      end
    end
    count
  end

  def current_player
    if turn_count.even?
      "X"
    else
      "O"
    end
  end

  def turn
    puts "Move?"
    this_move = gets
    i = input_to_index(this_move)
    if valid_move?(i)
      move(i, current_player)
      display_board
    else
      turn
    end
  end

  def won?
    @board.map.with_index do |sq, index|
      if sq == "X"
        @x_sqrs << index
      elsif sq == "O"
        @o_sqrs << index
      end
    end

    WIN_COMBINATIONS.find do |combo| 

      (@x_sqrs.include?(combo[0]) && @x_sqrs.include?(combo[1]) && @x_sqrs.include?(combo[2])) || (@o_sqrs.include?(combo[0]) && @o_sqrs.include?(combo[1]) && @o_sqrs.include?(combo[2]))
     
    end
  end

  def full?
    if !won? && !@board.find{|sq| sq == " "}
      true
    else
      false
    end
  end

  def draw?
   if !won? && !@board.find{|sq| sq == " "}
   true
    end
  end

  def over?
    if won? || !@board.find{|sq| sq == " "}
    true
    end
  end

  def winner
    if won?
      combo = won?
      if @x_sqrs.include?(combo[0]) && @x_sqrs.include?(combo[1]) && @x_sqrs.include?(combo[2])
        "X"
      elsif @o_sqrs.include?(combo[0]) && @o_sqrs.include?(combo[1]) && @o_sqrs.include?(combo[2])
        "O"
      end
    else won?
    end
  end

  def play 
    # binding.pry
    turn until over?

    if won?
      "Congratulations #{winner}!"
    elsif draw?
      "Draw!"
    else turn
    end
  end
end

