/*
  Switcher Automaton

  How it works: This is similar to the elementary automaton, except the rule changes every generation.
  The exact method of changing the rule is as follows: feed it an array of bytes, and it will do each
  successive rule in order, then loop back around once it's done.
*/

class SwitcherAutomaton extends Automaton {
  int size, iterCount;
  short[] rule;
  int[][] cells;
  
  int currentIteration;
  
  SwitcherAutomaton(short[] rule, int startConfig){
    this.size = width / multiplier;
    this.rule = rule;
    this.iterCount = height / multiplier;
    
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
    int current;
    
    this.currentIteration++;
    if (this.currentIteration < this.iterCount){
      for (int i = 0; i < this.size; i++){
        count = 4 * cells[this.currentIteration-1][mod(i-1, size)] + 2 * cells[this.currentIteration-1][i] + cells[this.currentIteration-1][mod(i+1, size)];
        current = i % rule.length;
        
        active = (this.rule[current] >> count) & 1;
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
        rect(row * multiplier, col * multiplier, multiplier, multiplier);
      }
    }
  }
  
  void renderRainbow(){
    for (int row = 0; row < this.size; row++){
      for (int col = 0; col < this.iterCount; col++){
        noStroke();
        
        colorMode(HSB, 100);
        
        color fillColor = (this.cells[col][row] == 1) ? color(col / 2 % 100, 70, 100) : color(0, 0, 0);
        fill(fillColor);
        rect(row * multiplier, col * multiplier, multiplier, multiplier);
      }
    }
  }
}
