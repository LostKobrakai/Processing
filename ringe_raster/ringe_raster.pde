int stepX;
int stepY;

void setup(){
  size(1280, 720, P2D);
  smooth(4);
  colorMode(RGB, 1);
  background(1);
  stepX = 40;
  stepY = 40;
  noFill();
  stroke(0);
}

void draw(){
  for(int h = 0; h < height; h += stepY){
    for(int w = 0; w < width; w += stepX){
      pushMatrix();
      translate(w, h);
      int r = floor(random(4));
      if(r == 0)      arc(0, 0, stepX * 2, stepY * 2, 0, TAU/4);
      else if(r == 1) arc(stepX, 0, stepX * 2, stepY * 2, TAU/4, TAU/2);
      else if(r == 2) arc(0, stepY, stepX * 2, stepY * 2, TAU*3/4, TAU);
      else if(r == 3) arc(stepX, stepY, stepX * 2, stepY * 2, TAU/2, TAU*3/4);
      else             rect(0,0,stepX,stepY);
      popMatrix();
    }
  }
}
