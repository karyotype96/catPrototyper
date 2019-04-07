/*
  Elementary Automaton

  How it works: The elementary automaton is 1-dimensional, and each cell can be
  in one of two states - on (1), or off (0). In each subsequent generation, the
  state of a cell at position i is determined by the states of cells i-1, i, and
  i+1 in the previous generation. The rule used is defined by an 8-bit number
  (0-255). Each bit will determine if a cell is on corresponding to the previous
  cell states in the neighborhood:
  
  111  110  101  100  011  010  001  000
   b7   b6   b5   b4   b3   b2   b1   b0
   
  For instance, in rule 30: (30 in base 2 is 00011110)
  
  111 110 101 100 011 010 001 000
   0   0   0   1   1   1   1   0
      
  This means that the cell is on if the previous states within the cell's
  neighborhood are:
  - 100, 011, 010, 001
  
  A few rules of interest include Rules 30 and 110.
*/

class ElementaryAutomaton extends Automaton {
  int size, iterCount;
  short rule;
  int[][] cells;
  
  int currentIteration;
  
  ElementaryAutomaton(short rule, int startConfig){
    this.size = width / 4;
    this.rule = rule;
    this.iterCount = height / 4;
    
    this.cells = new int[iterCount][size];
    
    this.currentIteration = 0;
    
    if (startConfig == CENTER_PIXEL){
      this.cells[0][size / 2] = 1;
    } else if (startConfig == FULLY_RANDOM){
      for (int i = 0; i < this.size; i++){
        this.cells[0][i] = int(floor(random(2)));
      }
    } else {
      println("Start config not valid. Defaulting to CENTER_PIXEL");
      this.cells[0][this.size / 2] = 1;
    }
  }
  
  void reset_board(int startConfig){
    this.currentIteration = 0;
    for (int row = 0; row < this.iterCount; row++){
      for (int col = 0; col < this.size; col++){
        this.cells[row][col] = 0;
      }
    }
    
    if (startConfig == CENTER_PIXEL){
      this.cells[0][this.size / 2] = 1;
    } else if (startConfig == FULLY_RANDOM){
      for (int i = 0; i < this.size; i++){
        this.cells[0][i] = floor(random(2));
      }
    } else {
      println("Start config not valid. Defaulting to CENTER_PIXEL");
      this.cells[0][this.size / 2] = 1;
    }
  }
  
  void iterate(){
    int active = 0;
    
    int count;
    
    this.currentIteration++;
    if (this.currentIteration < this.iterCount){
      for (int i = 0; i < this.size; i++){
        count = 4 * cells[this.currentIteration-1][mod(i-1, size)] + 2 * cells[this.currentIteration-1][i] + cells[this.currentIteration-1][mod(i+1, size)];
        active = (this.rule >> count) & 1;
        if (active == 1){ //<>//
          this.cells[this.currentIteration][i] = 1;
        }
      }
    }
  }
  
  void render(color[] colors){
    for (int row = 0; row < this.size; row++){
      for (int col = 0; col < this.iterCount; col++){
        noStroke();
        fill(colors[this.cells[col][row]]);
        rect(row * 4, col * 4, 4, 4);
      }
    }
  }
}
