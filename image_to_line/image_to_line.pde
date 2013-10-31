PImage img;

void setup(){
  img = loadImage("image.jpg");
  size(displayWidth, displayHeight);
  colorMode(RGB, 1);
  background(1);
  fill(1);
  stroke(0);
  frameRate(1);
}

int lin(int x, int y){
  return y * width + x;
}

int getMaxColor(int i, color[] p){
  int c = -1;
  float red = red(p[i]);
  float green = green(p[i]);
  float blue = blue(p[i]);
  float max = max(red , green, blue);
  
  if( red == blue && blue == green){
    c = (int) random(3);
  }else if(red == green){
    if(random(1) < 0.5) c = 0;
    else c = 1;
  }else if(red == blue){
    if(random(1) < 0.5) c = 0;
    else c = 2;
  }else if(green == blue){
    if(random(1) < 0.5) c = 1;
    else c = 2;
  }else if(red == max){
    c = 0;
  }else if(green == max){
    c = 1;
  }else if(blue == max){
    c = 2;
  }
  
  return c;
}

int getMaxColor(int i, color[] p, int c){
  int c1 = -1;
  float red = red(p[i]);
  float green = green(p[i]);
  float blue = blue(p[i]);
  float max = max(red , green, blue);
  
  if( red == blue && blue == green){
    c1 = 3;
  }else if(red == green){
    if(random(1) < 0.5) c1 = 0;
    else c1 = 1;
  }else if(red == blue){
    if(random(1) < 0.5) c1 = 0;
    else c1 = 2;
  }else if(green == blue){
    if(random(1) < 0.5) c1 = 1;
    else c1 = 2;
  }else if(red == max){
    c1 = 0;
  }else if(green == max){
    c1 = 1;
  }else if(blue == max){
    c1 = 2;
  }
  
  return c;
}

void drawLine(int x, int y, float angle, color[] p, int c, int n){
  
  int x1 = (int) sin(angle) + x;
  int y1 = (int) cos(angle) + y;
  int c1 = getMaxColor(n, p);
  line(x, y, x1, y1);
  
  if(c != c1){
    if(random(1) < 0.5) angle += TAU/4;
    else angle -= TAU/4;
  }
  
  n--;
  if( n>=0 ) drawLine(x1, y1, angle, p, c1, n);
}

void draw(){
  //Optional
  background(1);
  img.loadPixels();
  drawLine(width/2, height/2, TAU/4, img.pixels, getMaxColor(10000, img.pixels), 5000);
}
