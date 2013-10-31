PImage img;

void setup(){
  img = loadImage("bild.jpg");
  size(img.width * 2, img.height);
  colorMode(RGB, 1);
  background(1);
  noStroke();
  fill(1);
  frameRate(1);
}

int l(int x, int y){
  return y * width + x;
}

void draw(){
  //Optional
  background(1);
  image(img, 0, 0, img.width, img.height);
  
  translate(width/4, height/2);
  PVector q1 = new PVector(random(width/4), -1 * random(height/2));
  PVector q2 = new PVector(-1 * random(width/4), -1 * random(height/2));
  PVector q3 = new PVector(-1 * random(width/4), random(height/2));
  PVector q4 = new PVector(random(width/4), random(height/2));
  
  beginShape();
  vertex(q1.x, q1.y);
  vertex(q2.x, q2.y);
  vertex(q3.x, q3.y);
  vertex(q4.x, q4.y);
  endShape(CLOSE);
  
  loadPixels();
  img.loadPixels();
  for(int h = 0; h < height; h++){
    for(int w = 0; w < width/2; w++){
      if(pixels[ l(w, h) ] == color(1)){
        float red = 1 - red(img.pixels[ h * img.width + w ]);
        float green = 1 - green(img.pixels[ h * img.width + w ]);
        float blue = 1 - blue(img.pixels[ h * img.width + w ]);
        pixels[ l(w+width/2, h) ] = color(red, green, blue);
        pixels[ l(w, h) ] = color(red, green, blue);
      }
    }
  }
  updatePixels();
}
