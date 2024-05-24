
module TicTacToe
  LINES = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]

  class Game
    def initialize
      @board = Array.new(10, " ")
      @player1 = Player.new("X")
      @player2 = Player.new("O")
      @move = 0
    end

    def play
      print_board

      loop do
        if @move.even?
          @board[get_move('Player 1')] = @player1.marker
        else
          @board[get_move('Player 2')] = @player2.marker
        end

        @move += 1
        print_board

        if win?
          puts "#{@move.odd? ? "Player1" : "Player2"} has won!"
          break
        elsif draw?
          puts "It is a draw"
          break
        end
      end
    end

    private

    def get_move(player)
      print "#{player} selects: "
      move = gets.to_i
      while move < 1 || move > 9 || @board[move] != " "
        puts "Invalid move. Please enter a number from 1 to 9 that has not been used yet."
        move = gets.to_i
      end
      move
    end

    def print_board
      (1..9).each do |i|
        if @board[i] == " "
          print " #{i} "
        else
          print " #{@board[i]} "
        end
        print "|" if i % 3 != 0
        puts "\n-----------" if i % 3 == 0 && i != 9
      end
      puts
    end

    def win?
      LINES.any? do |line|
        @board[line[0]] == @board[line[1]] && @board[line[1]] == @board[line[2]] && @board[line[0]] != " "
      end
    end

    def draw?
      @board[1..-1].all? { |element| element != " "}
    end
  end

  class Player
    def initialize(marker)
      self.marker = marker
    end
    attr_accessor :marker
  end
end

game = TicTacToe::Game.new.play
