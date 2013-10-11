int radius;

void setup(){
  colorMode(HSB, 100);
  size(1280, 768);
  background(0,0,100);
  radius = 100;
}

void draw(){
  noStroke();
  fill(0,0,100,90);
  rect(0,0,width,height);
  
  translate(width/2, height/2);
  strokeWeight(2);
  stroke(0,0,0);
  float seed = random(1);
  for(float angle = 0.0; angle < 360.0; angle += 0.5){
    float x = (radius + noise(angle/360)*40) * sin(angle);
    float y = (radius + noise(angle/360)*40) * cos(angle);
    //x = (radius + noise(seed)*50) * sin(angle);
    //y = (radius + noise(seed)*50) * cos(angle);
    //x = radius * sin(angle);
    //y = radius * cos(angle);
    point(x, y);
  }
}
