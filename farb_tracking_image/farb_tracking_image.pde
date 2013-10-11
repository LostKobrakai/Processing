PImage img;

color search;
int diff;

void setup()
{
  img = loadImage("image.jpg");
  size(img.width, img.height);
  stroke(255,0,0);
  noFill();
  
  search = color(0,0,0);
  diff = 50;
}

void draw() {
  img = loadImage("image.jpg");
  img.loadPixels();
  if(mousePressed) search = img.pixels[mouseY*width+mouseX];
  
  int i = 0;
  for(int h = 0; h < height; h++){
    for(int w = 0; w < width; w++){
        //colorMode(HSB, 100);
        //img.pixels[i] = color(hue(img.pixels[i]), saturation(img.pixels[i]), 70);
        //colorMode(RGB, 255);
        float rc = red(img.pixels[i]);
        float gc = green(img.pixels[i]);
        float bc = blue(img.pixels[i]);
        
        float rs = red(search);
        float gs = green(search);
        float bs = blue(search);
      
      if(dist(rc, gc, bc, rs, gs, bs) <= diff){
        img.pixels[i] = color(255, 0, 0);
      }
      
      i++;
    }
  }

  img.updatePixels();   
  image(img, 0, 0, width, height);
}
