color[] oldP;
color dead;
color live;

void setup(){
  size(1280, 720);
  colorMode(RGB, 1);
  dead = color(0);
  live = color(1);
  oldP = new color[width * height];
  background(dead);
  stroke(live);
  frameRate(20);
  
  randomSeed();
  //point(width/2, 0);
}

void randomSeed(){
  background(dead);
  loadPixels();
  for(int i = 0; i < width; i++){
    if(random(1) >= .5) pixels[i] = live;
  }
  updatePixels();
  
  loadPixels();
  oldP = pixels;
  for(int h = 0; h < height-1; h++){
    for(int w = 0; w < width; w++){
      pixels[lin(w, h+1)] = color(check73(oldP, w, h), check120(oldP, w, h), 0);
    }
  }
  updatePixels();
}

void mousePressed(){
  randomSeed();
  //loop();
}

int lin(int x, int y){
  return y * width + x;
}

boolean checkCoords(int x, int y){
  if(x >= 0 && x < width && y >= 0 && y < height) return true;
  else return false;
}

int check73(color[] p, int x0, int y0){
  int i0 = lin(x0, y0);
  
  color c0 = p[i0];
  color c1;
  color c2;
  
  int x1 = abs((x0 - 1)%width);
  int i1 = lin(x1, y0);
  c1 = p[i1];
  
  int x2 = abs((x0 + 1)%width);
  int i2 = lin(x2, y0);
  c2 = p[i2];

       if( c1 != dead && c0 != dead && c2 != dead ) return 0;
  else if( c1 != dead && c0 != dead && c2 == dead ) return 1;
  else if( c1 != dead && c0 == dead && c2 != dead ) return 0;
  else if( c1 != dead && c0 == dead && c2 == dead ) return 0;
  else if( c1 == dead && c0 != dead && c2 != dead ) return 1;
  else if( c1 == dead && c0 != dead && c2 == dead ) return 0;
  else if( c1 == dead && c0 == dead && c2 != dead ) return 0;
  else if( c1 == dead && c0 == dead && c2 == dead ) return 1;
  else return dead;
}

int check120(color[] p, int x0, int y0){
  int i0 = lin(x0, y0);
  
  color c0 = p[i0];
  color c1;
  color c2;
  
  int x1 = abs((x0 - 1)%width);
  int i1 = lin(x1, y0);
  c1 = p[i1];
  
  int x2 = abs((x0 + 1)%width);
  int i2 = lin(x2, y0);
  c2 = p[i2];

       if( c1 != dead && c0 != dead && c2 != dead ) return 0;
  else if( c1 != dead && c0 != dead && c2 == dead ) return 1;
  else if( c1 != dead && c0 == dead && c2 != dead ) return 1;
  else if( c1 != dead && c0 == dead && c2 == dead ) return 1;
  else if( c1 == dead && c0 != dead && c2 != dead ) return 1;
  else if( c1 == dead && c0 != dead && c2 == dead ) return 0;
  else if( c1 == dead && c0 == dead && c2 != dead ) return 0;
  else if( c1 == dead && c0 == dead && c2 == dead ) return 0;
  else return dead;
}

void draw(){
  loadPixels();
  oldP = pixels;
  for(int h = 1; h < height; h++){
    for(int w = 0; w < width; w++){
      pixels[lin(w, h-1)] = oldP[lin(w, h)];
    }
  }
  for(int w = 0; w < width; w++){
    pixels[lin(w, height-1)] = color(check73(oldP, w, height-2), check120(oldP, w, height-2), 0);
  }
  updatePixels();
  //noLoop();
}
