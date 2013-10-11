int radius;

void setup(){
  size(1280, 720);
  colorMode(RGB, 1);
  background(0, 0, 0);
  noFill();
  smooth();
  ellipseMode(CENTER);
  strokeWeight(1);
  radius = width/4;
}

void draw(){
  //Slowly Fade Out
  pushStyle();
  noStroke();
  fill(0, 0, 0, 0.0001);
  rect(0, 0, width, height);
  popStyle();
  
  //Kreis
  stroke(1, 1, 0);
  translate(width/2, height/2);
  ellipse(0, 0, radius * 2, radius * 2);
  
  //Lines
  stroke(1, 1, 0, 0.7);
  
  float r1 = random(30, 160);
  float x1 = radius * sin(radians(frameCount + r1));
  float y1 = radius * cos(radians(frameCount + r1));
  
  float r2 = random(30, 160);
  float x2 = radius * sin(radians(frameCount+r2));
  float y2 = radius * cos(radians(frameCount+r2));
  
  line(x1, y1, x2, y2);
}
