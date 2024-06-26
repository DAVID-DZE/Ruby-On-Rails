const Gameboard = (() => {
  let board = ['', '', '', '', '', '', '', '', ''];

  const getBoard = () => board;

  const placeMarker = (index, marker) => {
      if (board[index] === '') {
          board[index] = marker;
          return true;
      }
      return false;
  };

  const reset = () => {
      board = ['', '', '', '', '', '', '', '', ''];
  };

  return { getBoard, placeMarker, reset };
})();

const Player = (name, marker) => {
  return { name, marker };
};

const GameController = (() => {
  let players = [];
  let currentPlayerIndex;
  let gameOver;

  const start = (player1Name, player2Name) => {
      players = [
          Player(player1Name, 'X'),
          Player(player2Name, 'O')
      ];
      currentPlayerIndex = 0;
      gameOver = false;
      Gameboard.reset();
  };

  const getCurrentPlayer = () => players[currentPlayerIndex];

  const switchPlayer = () => {
      currentPlayerIndex = currentPlayerIndex === 0 ? 1 : 0;
  };

  const playTurn = (index) => {
      if (gameOver) return false;

      if (Gameboard.placeMarker(index, getCurrentPlayer().marker)) {
          if (checkWin(index)) {
              gameOver = true;
              return 'win';
          } else if (checkTie()) {
              gameOver = true;
              return 'tie';
          }
          switchPlayer();
          return true;
      }
      return false;
  };

  const checkWin = (index) => {
      const winPatterns = [
          [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
          [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
          [0, 4, 8], [2, 4, 6] // Diagonals
      ];

      return winPatterns
          .filter(pattern => pattern.includes(index))
          .some(pattern => pattern.every(i => Gameboard.getBoard()[i] === getCurrentPlayer().marker));
  };

  const checkTie = () => {
      return Gameboard.getBoard().every(cell => cell !== '');
  };

  return { start, playTurn, getCurrentPlayer, checkWin, checkTie };
})();


const DisplayController = (() => {
  const gameContainer = document.getElementById('game-container');
  const gameStatus = document.getElementById('game-status');
  const player1Input = document.getElementById('player1');
  const player2Input = document.getElementById('player2');
  const startButton = document.getElementById('start-game');
  const restartButton = document.getElementById('restart-game');

  const renderBoard = () => {
      gameContainer.innerHTML = '';
      
      Gameboard.getBoard().forEach((cell, index) => {
          const cellElement = document.createElement('div');
          cellElement.classList.add('cell');
          cellElement.textContent = cell;
          cellElement.addEventListener('click', () => handleCellClick(index));
          gameContainer.appendChild(cellElement);
      });
  };

  const handleCellClick = (index) => {
      const result = GameController.playTurn(index);
      if (result === 'win') {
          gameStatus.textContent = `${GameController.getCurrentPlayer().name} wins!`;
          endGame();
      } else if (result === 'tie') {
          gameStatus.textContent = "It's a tie!";
          endGame();
      } else {
          updateStatus();
      }
      renderBoard();
  };

  const updateStatus = () => {
      gameStatus.textContent = `${GameController.getCurrentPlayer().name}'s turn`;
  };

  const endGame = () => {
      gameContainer.removeEventListener('click', handleCellClick);
      restartButton.style.display = 'block';
  };

  const init = () => {
      startButton.addEventListener('click', () => {
          const player1Name = player1Input.value || 'Player 1';
          const player2Name = player2Input.value || 'Player 2';
          GameController.start(player1Name, player2Name);
          renderBoard();
          updateStatus();
          document.getElementById('game-setup').style.display = 'none';
          gameContainer.style.display = 'grid';
          gameStatus.style.display = 'block';
      });

      restartButton.addEventListener('click', () => {
          GameController.start(player1Input.value || 'Player 1', player2Input.value || 'Player 2');
          renderBoard();
          updateStatus();
          restartButton.style.display = 'none';
          gameContainer.addEventListener('click', handleCellClick);
      });
  };

  return { init };
})();


DisplayController.init();