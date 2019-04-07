/*
  How it works: I'm going to assume that you already know how RPS works. Well,
  the RPS automaton runs on the same principle - a cell can be in one of three
  states, which are rock, paper, and scissors. For each cell, its next state
  will be determined by counting the number of cells that beat that one in its
  neighborhood, and if the number is greater than some threshold constant, it
  will be turned into a cell of the type that wins. That was a really horrible
  way of putting it, so I'll put it this way: let's say that the state of the
  cell is scissors. The cell doesn't worry about any paper cells in its
  neighborhood, but it does care about the number of rock cells. If our threshold
  is 3, then if there are 3 rock cells in its neighborhood, the cell we're looking
  at is turned from a scissors cell to a rock cell.
  
  Additionally, we define a "random" offset - that is, if we use N for our
  "random" number, then for each cell, the threshold will be a random number
  between the threshold T and T+N. When the threshold and random offset are 
  certain values, the automaton really likes making swirl patterns.
  
  Also, note: we could adapt these rules to a higher number of cell states. For
  instance, the famous "Rock, Paper, Scissors, Lizard, Spock". Here are the rules:
  rock beats scissors, rock crushes lizard, paper wraps rock, paper disproves Spock,
  scissors cuts paper, scissors stab lizard, lizard eats paper, lizard poisons Spock,
  Spock vaporizes rock, and Spock smashes scissors. Even following these rulesets,
  the automaton will continue to generate its famous swirly patterns, and this
  continues even if we add more and more cell states (look up RPS 101).
*/

class RPSAutomaton extends Automaton {
  int threshold, random;
  int wsize, hsize;
  int[][] cells;
  
  RPSAutomaton(int threshold, int random) {
    this.wsize = width / 4;
    this.hsize = width / 4;
    this.cells = new int[hsize][wsize];
    this.threshold = threshold;
    this.random = random;
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        this.cells[row][col] = floor(random(0, 3));
      }
    }
  }
  
  void reset_board(){
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        this.cells[row][col] = floor(random(0, 3));
      }
    }
  }
  
  void iterate(){
    int count;
    int[][] nextCells = new int[this.hsize][this.wsize];
    
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        count = 0;
        if (cells[mod(row-1, this.hsize)][mod(col-1, this.wsize)] == (this.cells[row][col] + 1) % 3)
          count++;
        if (cells[mod(row-1, this.hsize)][mod(col  , this.wsize)] == (this.cells[row][col] + 1) % 3)
          count++;
        if (cells[mod(row-1, this.hsize)][mod(col+1, this.wsize)] == (this.cells[row][col] + 1) % 3)
          count++;
        if (cells[mod(row  , this.hsize)][mod(col-1, this.wsize)] == (this.cells[row][col] + 1) % 3)
          count++;
        if (cells[mod(row  , this.hsize)][mod(col+1, this.wsize)] == (this.cells[row][col] + 1) % 3)
          count++;
        if (cells[mod(row+1, this.hsize)][mod(col-1, this.wsize)] == (this.cells[row][col] + 1) % 3)
          count++;
        if (cells[mod(row+1, this.hsize)][mod(col  , this.wsize)] == (this.cells[row][col] + 1) % 3)
          count++;
        if (cells[mod(row+1, this.hsize)][mod(col+1, this.wsize)] == (this.cells[row][col] + 1) % 3)
          count++;
          
        if (count > this.threshold + random(0, this.random + 1)){
          nextCells[row][col] = mod(this.cells[row][col] + 1, 3);
        } else {
          nextCells[row][col] = this.cells[row][col];
        }
      }
    }
    
    this.cells = nextCells;
  }
  
  void render(color[] colors){
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        noStroke();
        fill(colors[this.cells[row][col]]);
        rect(col * 4, row * 4, 4, 4);
      }
    }
  }
  
}
