class AnimateDots {
  // Setup
  float[][] p;
  float[][] p1;
  int l;
  int w;
  int h;
  
  AnimateDots(PImage img){
    p = new float[img.width*img.height][5];
    l = p.length; 
    w = img.width;
    h = img.height;
    
    img.loadPixels();
    for(int y = 0; y < h; y++){
      for(int x = 0; x < w; x++){
        int i = y * w + x;
        color c = img.pixels[i];
        p[i][0] = x; p[i][1] = y;
        p[i][2] = red(c); p[i][3] = green(c); p[i][4] = blue(c);
      }
    }
    
    p1 = p;
  }
  
  // Addition / Subtraction
  void addX(int i, float add){
    p[i][0] += add;
  }
  
  void addY(int i, float add){
    p[i][1] += add;
  }
  
  // Multiply / Division
  void multiX(int i, float multi){
    p[i][0] *= multi;
  }
  
  void multiY(int i, float multi){
    p[i][1] *= multi;
  }
  
  // Position Operation
  float getX(int i){
    return p[i][0];
  }
  
  float getY(int i){
    return p[i][1];
  }
  
  int[] getDim(){
    int[] dim = {w, h, l};
    return dim;
  }
  
  void setX(int i, float x){
    p[i][0] = x;
  }
  
  void setY(int i, float y){
    p[i][1]= y;
  }
  
  // Color Operation
  float getRed(int i){
    return p[i][2];
  }
  
  float getGreen(int i){
    return p[i][3];
  }
  
  float getBlue(int i){
    return p[i][4];
  }
  
  // Reset
  void reset(){
    p = p1;
  }
}
