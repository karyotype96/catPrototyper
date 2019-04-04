final int DEAD_EDGE = 0;
final int WRAP_GRID = 1;

final int CENTER_PIXEL       = 0;
final int FULLY_RANDOM       = 1;
final int RANDOM_CENTER_5X5  = 2;

abstract class Automaton {
  void reset_board(){
    
  }
  
  void resize_board(){
  
  }
  
  void set_iteration_count(){
  
  }
  
  int access_cell(){
    return 0;
  }
  
  void iterate(){
  
  }
  
  void render(){
    
  }
}
