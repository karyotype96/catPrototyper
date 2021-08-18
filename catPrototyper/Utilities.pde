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

color[] listGradient(int[] colors, int[] positions, int stepCount){
  color[] colorGradient = new color[stepCount];
  
  int colorIndex = 1;
  
  for (int i = 0; i < stepCount; i++){
    color c1 = colors[colorIndex-1];
    color c2 = colors[colorIndex];
    
    color toEnter = lerpColor(c1, c2, (float)(i - positions[colorIndex-1]) / (positions[colorIndex] - positions[colorIndex-1]));
    
    colorGradient[i] = toEnter;
    
    if (positions[colorIndex] == i){
      colorIndex++;
    }
    
  }
  
  return colorGradient;
}
