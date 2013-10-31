PImage img;
int max;
int start;
int speed;

void setup(){
  size(displayWidth, displayHeight, P2D);
  smooth(4);
  colorMode(RGB, 1);
  background(1);
  stroke(0);
  
  img = loadImage("image.jpg");
  max = img.width * img.height;
  speed = 100;
  start = 0;
}

void draw(){
  
  translate(width/2, height/2);
  //img.loadPixels();
  for(int i = start; i < start + speed; i++){
    float x = sin( radians(i%360) ) * i/300;
    float y = cos( radians(i%360) ) * i/300;
    point(x, y);
    println(x+", "+y);
  }
  
  start += speed;
  //speed = mouseY;
  if(start + speed >= max) noLoop();
}
