int mod(int a, int b){
  return (a % b + b) % b;
}

float clamp(float number, float lowBound, float highBound){
  float n = number;
  if (n < lowBound) n = lowBound;
  else if (n > highBound) n = highBound;
  
  return n;
}

color[] gradient(color c1, color c2, int stepCount){
  color[] colorList = new color[stepCount];
  for (int i = 0; i < stepCount; i++){
    colorList[i] = lerpColor(c1, c2, float(i) / stepCount);
  }
  
  return colorList;
}
