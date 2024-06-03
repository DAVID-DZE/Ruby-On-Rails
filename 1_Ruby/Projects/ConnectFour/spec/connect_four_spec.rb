require_relative '../connect_four'

describe ConnectFour do
  describe '#initialize' do
    # Initialize -> No test necessary when only creating instance variables.
  end

  describe '#play' do
    # Public Script Method -> No test necessary, but all methods inside should
    # be tested.
  end

  describe '#display_board' do
    context 'when the board is empty' do
      subject(:empty_board) { described_class.new }

      it 'displays an empty board' do
        expect { empty_board.display_board }.to output(
          " 1 2 3 4 5 6 7\n---------------\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n| | | | | | | |\n---------------\n"
        ).to_stdout
      end
    end

    context 'when the board has pieces' do
    end
  end

  describe '#player_move' do
    it 'placs a piece in the correct column' do
      game = described_class.new
      allow(game).to receive(:gets).and_return("1")
      game.player_move
      expect(game.instance_variable_get(:@board)).to eq(
        [[' ', ' ', ' ', ' ', ' ', ' ', ' '],
         [' ', ' ', ' ', ' ', ' ', ' ', ' '],
         [' ', ' ', ' ', ' ', ' ', ' ', ' '],
         [' ', ' ', ' ', ' ', ' ', ' ', ' '],
         [' ', ' ', ' ', ' ', ' ', ' ', ' '],
         ['☺', ' ', ' ', ' ', ' ', ' ', ' ']]
      )
    end

    it 'places two pieces in the same column at the lowest available spaces' do
      game = described_class.new
      allow(game).to receive(:gets).and_return("1")
      6.times { game.player_move }
      expect(game.instance_variable_get(:@board)).to eq(
        [['☺', ' ', ' ', ' ', ' ', ' ', ' '],
         ['☺', ' ', ' ', ' ', ' ', ' ', ' '],
         ['☺', ' ', ' ', ' ', ' ', ' ', ' '],
         ['☺', ' ', ' ', ' ', ' ', ' ', ' '],
         ['☺', ' ', ' ', ' ', ' ', ' ', ' '],
         ['☺', ' ', ' ', ' ', ' ', ' ', ' ']]
      )
      end
    end

  describe '#computer_move' do
    it 'places a piece in a random column' do
      game = described_class.new
      game.computer_move
      expect(game.instance_variable_get(:@board).flatten).to include('☻')
    end
  end

  describe '#winner?' do
    let(:game) { described_class.new }

    context 'when there is a horizontal winner' do
      it 'returns true' do
        game.instance_variable_set(:@board, [
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          ['☺', '☺', '☺', '☺', ' ', ' ', ' ']
        ])
        expect(game.horizontal_winner?('☺')).to be true
      end
    end

    context 'when there is a vertical winner' do
      it 'returns true' do
        game.instance_variable_set(:@board, [
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          ['☺', ' ', ' ', ' ', ' ', ' ', ' '],
          ['☺', ' ', ' ', ' ', ' ', ' ', ' '],
          ['☺', ' ', ' ', ' ', ' ', ' ', ' '],
          ['☺', ' ', ' ', ' ', ' ', ' ', ' ']
        ])
        expect(game.vertical_winner?('☺')).to be true
      end
    end

    context 'when there is a diagonal winner (right)' do
      it 'returns true' do
        game.instance_variable_set(:@board, [
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', '☺', ' ', ' ', ' '],
          [' ', ' ', '☺', ' ', ' ', ' ', ' '],
          [' ', '☺', ' ', ' ', ' ', ' ', ' '],
          ['☺', ' ', ' ', ' ', ' ', ' ', ' ']
        ])
        expect(game.diagonal_right?('☺')).to be true
      end
    end

    context 'when there is a diagonal winner (left)' do
      it 'returns true' do
        game.instance_variable_set(:@board, [
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', ' ', ' ', ' '],
          [' ', '☺', ' ', ' ', '', ' ', ' '],
          [' ', ' ', '☺', '', ' ', ' ', ' '],
          [' ', ' ', ' ', '☺', ' ', ' ', ' '],
          [' ', ' ', ' ', ' ', '☺', ' ', ' ']
        ])
        expect(game.diagonal_left?('☺')).to be true
      end
    end
  end

  describe '#print_result' do
    # Private Puts Method ->  No test necessary.
  end
end
