int stepX;
int stepY;
int gap;

void setup(){
  size(1280, 720, P2D);
  colorMode(RGB, 1);
  background(1);
  smooth(4);
  stepX = 80;
  stepY = 80;
  gap = 20;
  frameRate(10);
}

void draw(){
  for(int h = 0; h < height; h += stepY){
    for(int w = 0; w < width; w += stepX){
      stroke(random(1));
      noFill();
      line(w+gap/2,h+gap/2,w+stepX-gap/2,h+stepY-gap/2);
      line(w+stepX-gap/2,h+gap/2,w+gap/2,h+stepY-gap/2);
    }
  }
}
