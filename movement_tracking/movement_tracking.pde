import processing.video.*;
Capture cap;
PImage prevFrame;
float threshold = 50;

void setup() {
  size(1280,720);
  cap = new Capture(this, width, height, 30);
  cap.start();
  prevFrame = createImage(cap.width,cap.height,RGB);
}

void draw() {
  if (cap.available()) {
    prevFrame.copy(cap,0,0,cap.width,cap.height,0,0,cap.width,cap.height);
    prevFrame.updatePixels();
    cap.read();
  }
  
  loadPixels();
  cap.loadPixels();
  prevFrame.loadPixels();
  
  for (int x = 0; x < cap.width; x ++ ) {
    for (int y = 0; y < cap.height; y ++ ) {
      
      int loc = x + y*cap.width;
      color current = cap.pixels[loc];
      color previous = prevFrame.pixels[loc];
      
      float r1 = red(current); float g1 = green(current); float b1 = blue(current);
      float r2 = red(previous); float g2 = green(previous); float b2 = blue(previous);
      float diff = dist(r1,g1,b1,r2,g2,b2);
      
      if (diff > threshold) { 
        pixels[loc] = color(0);
      } else {
        pixels[loc] = color(255);
      }
    }
  }
  updatePixels();
}
