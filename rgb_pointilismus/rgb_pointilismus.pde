PImage img;
float[][] p;

int lin(int x, int y){
  return y * width + x;
}

void point_ani(int x, int y, float t){
  x += (t)*20;
  y += (t)*20;
  point(x, y);
}

void setup(){
  colorMode(RGB, 1);
  background(0, 0, 0);
  noFill();
  strokeWeight(3);
  
  img = loadImage("lara.jpg");
  size(img.width, img.height); 
  p = new float[img.width*img.height][5]; 
  img.loadPixels();
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
      int i = lin(x,y);
      color c = img.pixels[i];
      p[i][0] = x; p[i][1] = y;
      p[i][2] = red(c); p[i][3] = green(c); p[i][4] = blue(c);
    }
  }
}

void draw(){
  int t = frameCount;
  background(0, 0, 0);
  
  float red = noise(t, t/2, t/5) * 5 - 2;
  float blue = noise(t, t/5, t/4) * 5 - 2;
  float green = noise(t, t/4, t/7) * 5 - 2;
  
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
      if(x != 0 || y != 0){
        //Rot
        if(x%6 == 0 && y%5 == 0){
          float shade = p[lin(x,y)][2];
          stroke(shade, 0, 0);
          point_ani(x, y, red);
        }
        
        //Grün
        if(x%6 == 3 && y%5 == 3){
          float shade = p[lin(x,y)][3];
          stroke(0, shade, 0);
          point_ani(x, y, green);
        }
        
        //Blau
        if(x%6 == 4 && y%5 == 1){
          float shade = p[lin(x,y)][4];
          stroke(0, 0, shade);
          point_ani(x, y, blue);
        }
      }
    }
  }
}
