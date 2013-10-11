import processing.video.*;
Capture cap;

color search;
int diff;
boolean[][] result;

void setup()
{
  size(1280, 720);
  cap = new Capture(this, width, height, 30);
  cap.start();
  stroke(255,0,0);
  noFill();
  
  search = color(0,0,0);
  diff = 50;
  result = new boolean[width][height];
}

void draw() {
  if(cap.available() == true){
    cap.read();
    image(cap, 0, 0, width, height);
    cap.loadPixels();
    if(mousePressed) search = cap.pixels[mouseY*width+mouseX];
    
    int i = 0;
    int objx = 0;
    int objy = 0;
    for(int h = 0; h < height; h++){
      for(int w = 0; w < width; w++){
        float rc = red(cap.pixels[i]);
        float gc = green(cap.pixels[i]);
        float bc = blue(cap.pixels[i]);
        
        float rs = red(search);
        float gs = green(search);
        float bs = blue(search);
        
        if(dist(rc, gc, bc, rs, gs, bs) <= diff){
          cap.pixels[i] = color(255, 0, 0);
          objx = w;
          objy = h;
          result[w][h] = true;
        }else result[w][h] = false;
        
        i++;
      }
      //ellipse(objx, objy, 30, 30);
    }
    
    int[] lastHit = {0, 0};
    for(int h = 0; h < height; h++){
      for(int w = 0; w < width; w++){
        if(result[w][h] == true){
          if(dist(lastHit[0], lastHit[1], 0, w, h, 0) <= 5) line(lastHit[0], lastHit[1], w, h);
          lastHit[0] = w;
          lastHit[1] = h;
        }
      }
    }
    
    //cap.updatePixels();   
    //image(cap, 0, 0, width, height);
  }
}

