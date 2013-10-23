int stepX;
int stepY;

void setup(){
  size(1280, 720);
  colorMode(RGB, 1);
  stepX = 10;
  stepY = 10;
  frameRate(10);
}

void draw(){
  for(int h = 0; h < height; h += stepY){
    for(int w = 0; w < width; w += stepX){
      fill(random(1));
      rect(w, h, stepX, stepY);
    }
  }
}
