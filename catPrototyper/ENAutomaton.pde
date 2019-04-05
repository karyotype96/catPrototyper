/*
  Extended Neighborhood

  How it works: The extended neighborhood automaton is 1-dimensional, and it is
  defined similarly to the elementary automaton above. The catch is that the cell's
  neighborhood is of a larger size; whereas the elementary automaton's neighborhood
  is of size 3, we can say the EN automaton's neighborhood is size N, where N is some
  number where N = (b * 2) + 1. The number of possible cell states in a neighborhood
  of size N is 2^N, and the number of possible rules is 2^(2^N). For instance, if the
  neighborhood size N = 3, then there are 2^3 = 8 possible neighborhood configurations,
  and there are 2^8 = 256 possible rules. Likewise, if N = 5, then the number of
  possible cell states is 2^5 = 32, and the number of possible rules is 2^32 = 
  4,294,967,296 (oh, snap!).
*/

class ENAutomaton extends Automaton {
  int size, iterCount;
  long rule;
  int[][] cells;
  
  int currentIteration;
  
  ENAutomaton(long rule, int startConfig){
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
      this.cells[0][size / 2] = 1;
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
    long active = 0;
    
    int count;
    
    this.currentIteration++;
    if (this.currentIteration < this.iterCount){
      for (int i = 0; i < this.size; i++){
        count = 16 * cells[this.currentIteration-1][mod(i-2, size)]
               + 8 * cells[this.currentIteration-1][mod(i-1, size)]
               + 4 * cells[this.currentIteration-1][i] 
               + 2 * cells[this.currentIteration-1][mod(i+1, size)]
               + 1 * cells[this.currentIteration-1][mod(i+2, size)];
        active = (this.rule >> count) & 1;
        if (active == 1){
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
