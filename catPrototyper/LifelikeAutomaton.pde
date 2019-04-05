class LifelikeAutomaton extends Automaton {
  int wsize, hsize;
  ArrayList<Integer> bornCount, aliveCount;
  
  int[][] cells;
  
  LifelikeAutomaton(String rule, int startConfig){
    this.wsize = 200;
    this.hsize = 200;
    
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
      this.cells[this.hsize][this.wsize] = 1;
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
        total = this.cells[mod(row-1, this.hsize)][mod(col-1, this.hsize)]
              + this.cells[mod(row-1, this.hsize)][mod(col,   this.hsize)]
              + this.cells[mod(row-1, this.hsize)][mod(col+1, this.hsize)]
              + this.cells[mod(row  , this.hsize)][mod(col-1, this.hsize)]
              + this.cells[mod(row  , this.hsize)][mod(col+1, this.hsize)]
              + this.cells[mod(row+1, this.hsize)][mod(col-1, this.hsize)]
              + this.cells[mod(row+1, this.hsize)][mod(col  , this.hsize)]
              + this.cells[mod(row+1, this.hsize)][mod(col+1, this.hsize)];
              
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
