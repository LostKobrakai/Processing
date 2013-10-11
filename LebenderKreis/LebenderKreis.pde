int radius;

void setup(){
  colorMode(HSB, 100);
  size(1280, 768, P2D);
  background(0,0,100);
  smooth(8);
  noStroke();
  fill(0,0,100,90);
  radius = 100;
  frameRate(20);
}

void draw(){
  PShape s = createShape();
  s.beginShape();
  s.noStroke();
  s.fill(0,0,0);
  rect(0,0,width,height);
  
  float seed = noise(frameCount/10.0);

  for(float angle = 0.0; angle < 360.0; angle += 0.5){
    float nsin = 1.7 + sin( radians(angle) );
    float ncos = 1.34 + cos( radians(angle) );
    float sin = sin( radians( angle ) );
    float cos = cos( radians( angle ) );
    
    float noise = noise(nsin,  ncos, seed);
    
    float x = (radius + noise*10) * sin;
    float y = (radius + noise*10) * cos; 
    
    //x = (radius + noise(seed)*50) * sin(angle);
    //y = (radius + noise(seed)*50) * cos(angle);
    //x = radius * sin(angle);
    //y = radius * cos(angle);
    //line(x, y, 0, 0);
    s.vertex(x,y);
  }
  s.endShape();
  shape(s, width/2, height/2);
}
