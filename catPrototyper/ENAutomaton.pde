class ENAutomaton extends Automaton {
  int size, iterCount;
  long rule;
  int[][] cells;
  
  int currentIteration;
  
  ENAutomaton(long rule, int startConfig){
    this.size = 200;
    this.rule = rule;
    this.iterCount = 200;
    
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
