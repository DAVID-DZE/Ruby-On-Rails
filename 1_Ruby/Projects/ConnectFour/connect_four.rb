
class ConnectFour

  def initialize
    @board = Array.new(6) { Array.new(7, ' ') }
    @player, @computer = '☺', '☻'
  end

  def play
    display_board
    loop do
      player_move
      display_board
      if winner?(@player)
        print_result('You win!')
        break
      end
      computer_move
      display_board
      if winner?(@computer)
        print_result('Computer wins!')
        break
      end
    end
  end

  def display_board
    puts ' 1 2 3 4 5 6 7'
    puts '---------------'
    @board.each do |row|
      puts "|#{row.join('|')}|"
    end
    puts '---------------'
  end

  def player_move
    puts 'Enter a column number between 1 and 7 to place your piece:'
    column = gets.chomp.to_i
    @board.reverse.each do |row|
      if row[column - 1] == ' '
        row[column - 1] = @player
        break
      end
    end
  end

  def computer_move
    column = rand(1..7)
    @board.reverse.each do |row|
      if row[column - 1] == ' '
        row[column - 1] = @computer
        break
      end
    end
  end

  def winner?(piece)
    horizontal_winner?(piece) || vertical_winner?(piece) || diagonal_winner?(piece)
  end

  def horizontal_winner?(piece)
    @board.each do |row|
      return true if row.join.include?(piece * 4)
    end
    false
  end

  def vertical_winner?(piece)
    @board.transpose.each do |row|
      return true if row.join.include?(piece * 4)
    end
    false
  end

  def diagonal_winner?(piece)
    diagonal_right?(piece) || diagonal_left?(piece)
  end

  def diagonal_left?(piece)
    3.times do |row|
      4.times do |column|
        return true if [@board[row][column], @board[row + 1][column + 1], @board[row + 2][column + 2], @board[row + 3][column + 3]].join.include?(piece * 4)
      end
    end
    false
  end

  def diagonal_right?(piece)
    3.times do |row|
      4.times do |column|
        return true if [@board[row][column + 3], @board[row + 1][column + 2], @board[row + 2][column + 1], @board[row + 3][column]].join.include?(piece * 4)
      end
    end
    false
  end

  def print_result(message)
    puts '---------------'
    puts message
    puts '---------------'
  end
end

game = ConnectFour.new
game.play
