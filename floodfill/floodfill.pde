PImage img;

int diff;
int px;
color fillC;
color test;

void setup()
{
  img = loadImage("image.jpg");
  size(img.width, img.height);
  stroke(255,0,0);
  noFill();
  px = width*height;
  fillC = color(255,0,0);
  diff = 50;
}

int l(int x, int y){
  return x + (y * width);
}

color[] flood(int x, int y, color[] pixel){
  if(x<0 || x>= width || y < 0 || y >= height) return pixel;
  
  float rt = red(test);
  float gt = green(test);
  float bt = blue(test);
  
  float rc = red(pixel[l(x, y)]);
  float gc = green(pixel[l(x, y)]);
  float bc = blue(pixel[l(x, y)]);
  
  if(dist(rt, gt, bt, rc, gc, bc) <= diff){
    println(dist(rt, gt, bt, rc, gc, bc));
    pixel[l(x, y)] = fillC;
    
    pixel = flood(x+1, y, pixel);
    pixel = flood(x-1, y, pixel);
    pixel = flood(x, y+1, pixel);
    pixel = flood(x, y-1, pixel);
  }
  return pixel;
}

void draw() {
  if(mousePressed){
    img.loadPixels();
    
    test = img.pixels[l(mouseX, mouseY)];
    img.pixels = flood(mouseX, mouseY, img.pixels);
    
    img.updatePixels();
  }
  image(img, 0, 0, width, height);
}
