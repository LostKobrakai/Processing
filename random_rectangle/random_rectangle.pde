void setup(){
  size(displayWidth/2, displayHeight);
  colorMode(RGB, 1);
  background(1);
  stroke(0);
  noFill();
}

void draw(){
  translate(width/2, height/2);
  PVector q1 = new PVector(random(width/2), -1 * random(height/2));
  PVector q2 = new PVector(-1 * random(width/2), -1 * random(height/2));
  PVector q3 = new PVector(-1 * random(width/2), random(height/2));
  PVector q4 = new PVector(random(width/2), random(height/2));
  
  beginShape();
  vertex(q1.x, q1.y);
  vertex(q2.x, q2.y);
  vertex(q3.x, q3.y);
  vertex(q4.x, q4.y);
  endShape(CLOSE);
}
