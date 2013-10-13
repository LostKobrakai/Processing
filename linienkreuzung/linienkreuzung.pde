Line line01;
color bg;
RingBuffer buff;

void setup(){
  size(1280, 720, P2D);
  colorMode(RGB, 1);
  bg = color(1,1,1);
  background(bg);
  strokeWeight(2);
  
  buff = new RingBuffer(width*height);
  line01 = new Line(0,0,20);
  buff.push(line01);
}

void draw(){
  background(bg);
  line(0,720,1280,0);
  loadPixels();
  line01.drawLine(pixels, bg);
}
