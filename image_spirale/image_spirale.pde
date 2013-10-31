PImage img;
int max;
int start;
int speed;

void setup(){
  size(displayWidth, displayHeight, P2D);
  smooth(4);
  colorMode(RGB, 1);
  background(0);
  stroke(0);
  
  img = loadImage("image.jpg");
  max = img.width * img.height;
  speed = 500;
  start = 0;
}

void draw(){
  
  /*------------Great Parameter-----------------
  
  background(0); 
  angle( i / 128 );
  radius( i / 10000 );
  
  background(1); 
  angle( i );
  radius( i / 300 );
  
  background(1); 
  angle sin( i / 128 );
  angle cos(i / 32 );
  radius( i / 10000 );
  */
  
  translate(width/2, height/2);
  img.loadPixels();
  for(int i = start; i < start + speed; i++){
    stroke( img.pixels[i] );
    
    float x = sin( radians(i / 128) ) * i / 10000;
    float y = cos( radians(i / 32) ) * i / 10000;
    point(x, y);
  }
  
  start += speed;
  speed = speed + floor((mouseY * 1.0/height) * speed);
  if(start + speed >= max) noLoop();
}
