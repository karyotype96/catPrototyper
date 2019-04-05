/*
  Life-like

  How it works: Life-like automata are defined in a similar manner to Conway's Game of
  Life. For reference, Conway's Game of Life takes place on a 2-dimensional grid where
  the state of each cell is determined by how many live cells are in its neighborhood.
  The Game of Life has the following rule: a dead cell will come to life if its
  neighborhood contains 3 live cells, a live cell will stay alive if its neighborhood
  contains 2 or 3 live cells, and under all other circumstances, the cell dies or stays
  dead. Because this rule is simple enough for this type of defined behavior, we can say
  that there are two sets of rules: the number of cells required for a dead cell to be
  born (we'll call this set [x]), and the number of cells required for a live cell to stay
  alive (we call this [y]). We can thus write the rulestring as B[x]/S[y]. Following this
  format, the Game of Life's rulestring would be "B3/S23".
*/

class LifelikeAutomaton extends Automaton {
  int wsize, hsize;
  ArrayList<Integer> bornCount, aliveCount;
  
  int[][] cells;
  
  LifelikeAutomaton(String rule, int startConfig){
    this.wsize = width / 4;
    this.hsize = height / 4;
    
    String[] splitStr = rule.split("/");
    splitStr[0] = splitStr[0].substring(1, splitStr[0].length());
    splitStr[1] = splitStr[1].substring(1, splitStr[1].length());
    
    this.bornCount = new ArrayList<Integer>();
    this.aliveCount = new ArrayList<Integer>();
    
    for (char c : splitStr[0].toCharArray()){
      bornCount.add(Integer.parseInt(Character.toString(c)));
    }
    
    for (char c : splitStr[1].toCharArray()){
      aliveCount.add(Integer.parseInt(Character.toString(c)));
    }
    
    this.cells = new int[this.hsize][this.wsize];
    
    if (startConfig == CENTER_PIXEL){
      this.cells[this.hsize / 2][this.wsize / 2] = 1;
    } else if (startConfig == FULLY_RANDOM){
      for (int row = 0; row < this.hsize; row++){
        for (int col = 0; col < this.wsize; col++){
          this.cells[row][col] = floor(random(0, 2));
        }
      }
    } else if (startConfig == RANDOM_CENTER_5X5){
      for (int row = this.hsize / 2 - 2; row < this.hsize / 2 + 3; row++){
        for (int col = this.wsize / 2 - 2; col < this.wsize / 2 + 3; col++){
          this.cells[row][col] = floor(random(0, 2));
        }
      }
    } else {
      println("Start config not valid. Setting default states to RANDOM_CENTER_5X5...");
      for (int row = this.hsize / 2 - 2; row < this.hsize / 2 + 3; row++){
        for (int col = this.wsize / 2 - 2; col < this.wsize / 2 + 3; col++){
          this.cells[row][col] = floor(random(0, 2));
        }
      }
    }
    
  }
  
  void reset_board(int startConfig){
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        this.cells[row][col] = 0;
      }
    }
    
    if (startConfig == CENTER_PIXEL){
      this.cells[this.hsize / 2][this.wsize / 2] = 1;
    } else if (startConfig == FULLY_RANDOM){
      for (int row = 0; row < this.hsize; row++){
        for (int col = 0; col < this.wsize; col++){
          this.cells[row][col] = floor(random(0, 2));
        }
      }
    } else if (startConfig == RANDOM_CENTER_5X5){
      for (int row = this.hsize / 2 - 2; row < this.hsize / 2 + 3; row++){
        for (int col = this.wsize / 2 - 2; col < this.wsize / 2 + 3; col++){
          this.cells[row][col] = floor(random(0, 2));
        }
      }
    } else {
      println("Start config not valid. Setting default states to RANDOM_CENTER_5X5...");
      for (int row = this.hsize / 2 - 2; row < this.hsize / 2 + 3; row++){
        for (int col = this.wsize / 2 - 2; col < this.wsize / 2 + 3; col++){
          this.cells[row][col] = floor(random(0, 2));
        }
      }
    }
    
  }
  
  void iterate(){
    int total;
    int nextCells[][] = new int[this.hsize][this.wsize];
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        total = this.cells[mod(row-1, this.hsize)][mod(col-1, this.wsize)]
              + this.cells[mod(row-1, this.hsize)][mod(col,   this.wsize)]
              + this.cells[mod(row-1, this.hsize)][mod(col+1, this.wsize)]
              + this.cells[mod(row  , this.hsize)][mod(col-1, this.wsize)]
              + this.cells[mod(row  , this.hsize)][mod(col+1, this.wsize)]
              + this.cells[mod(row+1, this.hsize)][mod(col-1, this.wsize)]
              + this.cells[mod(row+1, this.hsize)][mod(col  , this.wsize)]
              + this.cells[mod(row+1, this.hsize)][mod(col+1, this.wsize)];
              
        if (this.cells[row][col] == 0){
          nextCells[row][col] = (this.bornCount.contains(total)) ? 1 : 0;
        } else {
          nextCells[row][col] = (this.aliveCount.contains(total)) ? 1 : 0;
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
