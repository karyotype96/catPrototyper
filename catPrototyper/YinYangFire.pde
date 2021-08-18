/* 
  Yin Yang Fire

  How it works: The value of each cell can be anywhere from 0 to 63. Every iteration, it
  gets the sum of all neighboring cells. If the value of the current cell is defined as
  "cellValue", then we check if cellValue * 9 + 2 is greater than or equal to the cell sum.
  If it is, we subtract 1 from it. If the resulting number from THAT is less than 0, the state
  is set to stateCount - 1. If cellValue * 9 + 2 is less than the cell sum, the result is
  incremented by 1 instead. The patterns tend to oscillate, with pattern fluctuations being
  very slow.
*/

class YinYangFire extends Automaton {
  int wsize, hsize;
  int cells[][];
  int stateCount;
  
  YinYangFire(int stateCount){
    wsize = width / multiplier;
    hsize = height / multiplier;
    
    this.stateCount = stateCount;
    
    cells = new int[hsize][wsize];
    
    for (int row = 0; row < cells.length; row++){
      for (int col = 0; col < cells[0].length; col++){
        cells[row][col] = floor(random(0, stateCount));
      }
    }
  }
  
  void reset_board(int startConfig){
    this.cells = new int[this.hsize][this.wsize];
    
    if (startConfig == FULLY_RANDOM){
      for (int row = 0; row < cells.length; row++){
        for (int col = 0; col < cells[0].length; col++){
          cells[row][col] = floor(random(0, stateCount));
        }
      }
    } else if (startConfig == RANDOM_CENTER_5X5){
      for (int row = this.hsize / 2 - 2; row < this.hsize / 2 + 3; row++){
        for (int col = this.wsize / 2 - 2; col < this.wsize / 2 + 3; col++){
          this.cells[row][col] = floor(random(0, stateCount));
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
  
  void reset_board(){
    this.reset_board(FULLY_RANDOM);
  }
  
  void iterate(){
    int[][] nextCells = new int[hsize][wsize];
    
    for (int row = 0; row < cells.length; row++){
      for (int col = 0; col < cells[0].length; col++){
        int cellValue = this.cells[row][col];
        int result = cellValue;
        
        int cellSum = this.cells[mod(row-1, this.hsize)][mod(col-1, this.wsize)]
                    + this.cells[mod(row-1, this.hsize)][mod(col  , this.wsize)]
                    + this.cells[mod(row-1, this.hsize)][mod(col+1, this.wsize)]
                    + this.cells[mod(row  , this.hsize)][mod(col-1, this.wsize)]
                    + this.cells[mod(row  , this.hsize)][mod(col+1, this.wsize)]
                    + this.cells[mod(row+1, this.hsize)][mod(col-1, this.wsize)]
                    + this.cells[mod(row+1, this.hsize)][mod(col  , this.wsize)]
                    + this.cells[mod(row+1, this.hsize)][mod(col+1, this.wsize)];
        
        if (cellValue * 9 + 2 >= cellSum){
          result -= 1;
          if (result < 0){
            result = stateCount - 1;
          }
        } else {
          result = cellValue + 1;
        }
        
        nextCells[row][col] = result;
      }
    }
    
    this.cells = nextCells;
  }
  
  void render(color[] colors){
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        noStroke();
        fill(colors[this.cells[row][col]]);
        rect(col * multiplier, row * multiplier, multiplier, multiplier);
      }
    }
  }
}
