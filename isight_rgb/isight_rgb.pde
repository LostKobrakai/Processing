import processing.video.*;
Capture cap;
void setup()
{
  size(1280, 720+100);
  cap = new Capture(this, width, height, 30);
  cap.start();
  noStroke();
}
void draw() {
  if(cap.available() == true){
    int[] colors = new int[3];
    cap.read();
    cap.loadPixels();
    for(int i = 0; i < width * height; i++){
      float redC = red(cap.pixels[i]);
      float greenC = green(cap.pixels[i]);
      float blueC = blue(cap.pixels[i]);
      
      float max = max(redC, greenC, blueC);
      if(max ==  redC){
        colors[0]++;
        cap.pixels[i] = color(redC, greenC/2, blueC/2);
      }
      if(max ==  greenC){
        colors[1]++;
        cap.pixels[i] = color(redC/2, greenC, blueC/2);
      }
      if(max ==  blueC){
        colors[2]++;
        cap.pixels[i] = color(redC/2, greenC/2, blueC);
      }
    }
    cap.updatePixels();
    background(0,0,0);
    for(int i = 0; i < colors.length; i++){
      int rectH = colors[i]*100/( width*height );
      if(i==0) fill(255,0,0);
      if(i==1) fill(0,255,0);
      if(i==2) fill(0,0,255);
      rect(i*30, height-rectH, 30, rectH);
    }
    image(cap, 0, 0, 1280, 720);
  }
}

