//HTML Elements
const board = document.getElementById("board");
const scoreBoard = document.getElementById("scoreBoard");
const startButton = document.getElementById("start");
const gameOverSign = document.getElementById("gameOver");

//game settings
const boardSize = 10;
const gameSpeed = 100;
const squareTypes = {
  emptySquare: 0,
  snakeSquare: 1,
  foodSquare: 2,
};
const directions = {
  ArrowUp: -10,
  ArrowDown: 10,
  ArrowRight: 1,
  ArrowLeft: -1,
};


const drawSnake = () => {
  snake.forEach(square => drawSquare(square, 'snakeSquare'));
}

//Game variables
let snake;
let score;
let direction;
let boardSquares;
let emptySquares;
let moveInterval;

//Rellena cadad recuadro del tablero
//@params
//square: posicion del tablero
//type: tipo de cuadrado (emptySquare, snakeSquare, foodSquare)
const drawSquare = (square, type) => {
  const [row, column] = square.split('');
  boardSquares[row][column] = squareTypes[type];
  const squareElement = document.getElementById(square);
  squareElement.setAttribute('class', `square ${type}`);
  
  if(type === 'emptySquare'){
    emptySquares.push(square);
  } else {
    if(emptySquares.indexOf(square) !== -1){
      emptySquares.splice(emptySquares.indexOf(square), 1);
    }
  }
}

const createBoard = () => {
  boardSquares.forEach((row, rowIndex) => {
    row.forEach((column, columnIndex) => {
      const squareValue = `${rowIndex}${columnIndex}`;
      const squareElement = document.createElement("div");
      squareElement.setAttribute("class", "square emptySquare");
      squareElement.setAttribute("id", squareValue);
      board.appendChild(squareElement);
      emptySquares.push(squareValue); 
    });
  });
};

const setGame = () => {
  snake = ["00", "01", "02", "03"];
  score = snake.length;
  boardSquares = Array.from(Array(boardSize), () =>
    new Array(boardSize).fill(squareTypes.emptySquare),
  );
  console.log(boardSquares);
  board.innerHTML = "";
  emptySquares = [];
  createBoard();
};

setGame();
const startGame = () => {
  setGame();
  gameOverSign.style.display = 'none';
  startButton.disabled = true;
  drawSnake();
};

startButton.addEventListener("click", startGame);
