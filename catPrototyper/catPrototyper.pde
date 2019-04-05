// How to use: Uncomment whatever automaton you want to use,
// then set the colors, then start the program and press space to 
// advance the time.

/*
  Here are some rulestrings for particularly interesting automaton rules:

  ELEMENTARY AUTOMATA:
    30
    45
    60
    110
    122
    
  LIFELIKE AUTOMATA:
    Anneal:                 B4678/S35678
    Conway's Game of Life:  B3/S23
    Day & Night:            B3678/S34678
    Diamoeba:               B35678/S5678
    HighLife:               B36/S23
    Life Without Death:     B3/S012345678
    Morley:                 B368/S245
    Seeds:                  B2/S
    
*/

Automaton aut;
final color[] colors = {#005000, #00FF00};

void setup(){
  size(800, 800);
  // aut = new ElementaryAutomaton((short)60, FULLY_RANDOM);
  // aut = new ENAutomaton(2837281162L, FULLY_RANDOM);
  aut = new LifelikeAutomaton("B2/S", RANDOM_CENTER_5X5);
  noSmooth();
}

void draw(){
  background(0);
  aut.render(colors);
}

void keyPressed(){
  if (key == ' ')
    aut.iterate();
}
