ElementaryAutomaton aut;
final color[] colors = {color(255, 255, 255), color(0, 0, 0)};

void setup(){
  size(800, 800);
  aut = new ElementaryAutomaton(30, CENTER_PIXEL);
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
