final int HEALTHY   = 0;
final int INFECTED  = 1;
final int ILL       = 2;

/*
  Hodgepodge Machine

  How it works: The hodgepodge machine is a (rather obscure) cellular automaton that is used
  primarily to simulate Belousov-Zhabotinsky reactions. Cells can be in any one of N+1 states
  - that is, a cell's state can be anything from 0 to N. A cell that is at state 0 is said to
  be "healthy", a cell at state N is "ill", and any cells in between are "infected".
  What happens to each cell depends on the states of the cells around it. For the following, we
  define the constants k1, k2, and g (they can be pretty much anything), and we say that for
  each cell, A equals the number of infected cells in its neighborhood, B is the number of ill
  cells, and S is the sum of the states of the cell's neighbors and itself. 
  
  - If the cell is healthy, its next state is determined by the formula (A / k1) + (B / k2).
  - If the cell is infected, its next state will be S / (A + B + 1) + g.
  - If the cell is ill, it will become healthy again, as if by magic.
*/

class HodgepodgeMachine extends Automaton {
  int stateCount;
  int k1, k2, g;
  int wsize, hsize;
  
  int[][] cells;
  
  HodgepodgeMachine(int stateCount, int k1, int k2, int g){
    this.wsize = width / 4;
    this.hsize = height / 4;
    this.stateCount = stateCount;
    this.k1 = k1;
    this.k2 = k2;
    this.g = g;
    
    this.cells = new int[this.hsize][this.wsize];
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        this.cells[row][col] = floor(random(0, this.stateCount+1));
      }
    }
  }
  
  void reset_board(){
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        this.cells[row][col] = floor(random(0, this.stateCount+1));
      }
    }
  }
  
  private int getState(int row, int col){
    int state = HEALTHY;
    if (this.cells[row][col] > 0 && this.cells[row][col] < this.stateCount){
      state = INFECTED;
    } else if (this.cells[row][col] == this.stateCount){
      state = ILL;
    }
    return state;
  }
  
  void iterate(){
    int[][] nextCells = new int[this.hsize][this.wsize];
    int current;
    int A, B, S;
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        current = getState(row, col);
        A = 0;
        B = 0;
        A += (getState(mod(row-1, this.hsize), mod(col-1, this.wsize)) == INFECTED) ? 1 : 0;
        A += (getState(mod(row-1, this.hsize), mod(col  , this.wsize)) == INFECTED) ? 1 : 0;
        A += (getState(mod(row-1, this.hsize), mod(col+1, this.wsize)) == INFECTED) ? 1 : 0;
        A += (getState(mod(row  , this.hsize), mod(col-1, this.wsize)) == INFECTED) ? 1 : 0;
        A += (getState(mod(row  , this.hsize), mod(col+1, this.wsize)) == INFECTED) ? 1 : 0;
        A += (getState(mod(row+1, this.hsize), mod(col-1, this.wsize)) == INFECTED) ? 1 : 0;
        A += (getState(mod(row+1, this.hsize), mod(col  , this.wsize)) == INFECTED) ? 1 : 0;
        A += (getState(mod(row+1, this.hsize), mod(col+1, this.wsize)) == INFECTED) ? 1 : 0;
        
        B += (getState(mod(row-1, this.hsize), mod(col-1, this.wsize)) == ILL) ? 1 : 0;
        B += (getState(mod(row-1, this.hsize), mod(col  , this.wsize)) == ILL) ? 1 : 0;
        B += (getState(mod(row-1, this.hsize), mod(col+1, this.wsize)) == ILL) ? 1 : 0;
        B += (getState(mod(row  , this.hsize), mod(col-1, this.wsize)) == ILL) ? 1 : 0;
        B += (getState(mod(row  , this.hsize), mod(col+1, this.wsize)) == ILL) ? 1 : 0;
        B += (getState(mod(row+1, this.hsize), mod(col-1, this.wsize)) == ILL) ? 1 : 0;
        B += (getState(mod(row+1, this.hsize), mod(col  , this.wsize)) == ILL) ? 1 : 0;
        B += (getState(mod(row+1, this.hsize), mod(col+1, this.wsize)) == ILL) ? 1 : 0;
        
        S = this.cells[mod(row-1, this.hsize)][mod(col-1, this.wsize)]
          + this.cells[mod(row-1, this.hsize)][mod(col  , this.wsize)]
          + this.cells[mod(row-1, this.hsize)][mod(col+1, this.wsize)]
          + this.cells[mod(row  , this.hsize)][mod(col-1, this.wsize)]
          + this.cells[mod(row  , this.hsize)][mod(col  , this.wsize)]
          + this.cells[mod(row  , this.hsize)][mod(col+1, this.wsize)]
          + this.cells[mod(row+1, this.hsize)][mod(col-1, this.wsize)]
          + this.cells[mod(row+1, this.hsize)][mod(col  , this.wsize)]
          + this.cells[mod(row+1, this.hsize)][mod(col+1, this.wsize)];
        
        if (current == HEALTHY){
          nextCells[row][col] = (A / this.k1) + (B / this.k2);
        } else if (current == INFECTED){
          nextCells[row][col] = floor(clamp(S / (A + B + 1) + this.g, 0, this.stateCount));
        } else {
          nextCells[row][col] = 0;
        }
      }
    }
    this.cells = nextCells;
  }
  
  void render(color[] colors){
    for (int row = 0; row < this.hsize; row++){ //<>//
      for (int col = 0; col < this.wsize; col++){
        noStroke();
        fill(colors[this.cells[row][col]]);
        rect(col * multiplier, row * multiplier, multiplier, multiplier);
      }
    }
  }
  
  void renderRainbow(){
    for (int row = 0; row < this.hsize; row++){
      for (int col = 0; col < this.wsize; col++){
        noStroke();
        
        colorMode(HSB, 100);
        
        color fillColor = color(map(this.cells[row][col], 0, this.stateCount, 0, 100), 70, 100);
        fill(fillColor);
        rect(col * multiplier, row * multiplier, multiplier, multiplier);
      }
    }
  }
}
