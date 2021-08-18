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

final int hodgepodgeCount = 200;

final int speed = 8; // number of times to iterate the automaton before updating the display
final int multiplier = 4; // optimal multiplier is 4

boolean autoAdvance = true; // if true, will advance without space bar input

// will show in rainbow colors if set to true.
// otherwise, it uses the colors shown below.
// works on all except RPS automaton.
// cute, right? :D
final boolean rainbow = false;

Automaton aut;
final color[] colors = {#000000, #00FFFF};
final color[] hodgepodgeColors = gradient(colors[0], colors[1], hodgepodgeCount+1);
final color[] rpsColors = {#FF0000, #00FF00, #0000FF};
final color[] yyfColors = listGradient(new color[]{#000000, #FF0000, #FFFFFF}, new int[]{0, 50, 63}, 64);

void setup(){
  size(1600, 800);
  // aut = new ElementaryAutomaton((short)26, CENTER_PIXEL);
  // aut = new SwitcherAutomaton(new short[]{214}, CENTER_PIXEL);
  // aut = new ENAutomaton(90918187261L, FULLY_RANDOM);
  // aut = new LifelikeAutomaton("B4678/S35678", FULLY_RANDOM);
  // aut = new HodgepodgeMachine(hodgepodgeCount, 3, 3, 28);
  // aut = new RPSAutomaton(2, 2);
  aut = new YinYangFire(64);
  noSmooth();
}  

void draw(){
  background(0);
  
  if (autoAdvance){
    for (int i = 0; i < speed; i++){
      aut.iterate();
    }
  }
  
  if (aut instanceof HodgepodgeMachine) {
    if (rainbow){
      aut.renderRainbow();
    } else {
      aut.render(hodgepodgeColors);
    }
  } else if (aut instanceof RPSAutomaton) {
    aut.render(rpsColors);
  } else if (aut instanceof YinYangFire){
    aut.render(yyfColors);
  } else {
    if (rainbow){
      aut.renderRainbow();
    } else {
      aut.render(colors);
    }
  }
}

void keyPressed(){
  if (key == ' ')
    for (int i = 0; i < speed; i++){
      aut.iterate();
    }
  else if (key == '1' || key == '2' || key == '3'){
    if (!((aut instanceof HodgepodgeMachine) || (aut instanceof RPSAutomaton))){
      if (key == '1' && !(aut instanceof HodgepodgeMachine))
        aut.reset_board(CENTER_PIXEL);
      if (key == '2' && !(aut instanceof HodgepodgeMachine))
        aut.reset_board(FULLY_RANDOM);
      if (key == '3' && !(aut instanceof HodgepodgeMachine))
        aut.reset_board(RANDOM_CENTER_5X5);
    } else {
      aut.reset_board();
    }
  }
}
