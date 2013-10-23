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
  background(1);
  for(int h = 0; h < height; h += stepY){
    for(int w = 0; w < width; w += stepX){
      stroke(0);
      noFill();
      pushMatrix();
      translate((w + stepX/2), (h + stepY/2));
      rotate(noise(millis(), w*1.0/width, h*1.0/height)*TAU);
      line(-stepX/4,-stepY/4,stepX/4,stepY/4);
      line(stepX/4,-stepY/4,-stepX/4,stepY/4);
      popMatrix();
    }
  }
}
