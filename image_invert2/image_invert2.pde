PImage img;
int max;
int start;
int speed;

PVector q1;
PVector q2;
PVector q3;
PVector q4;

void setup(){
  img = loadImage("image4.jpg");
  size(img.width, img.height, P2D);
  smooth(4);
  colorMode(RGB, 1);
  background(1);
  stroke(0);
  frameRate(1);
}

int l(int x, int y){
  return y * width + x;
}

boolean isOdd(int n){
  if(n % 2 != 0) return true;
  else return false;
}

boolean isMiddle(int n){
  if( !isOdd( floor(width/2) ) ) return false;
  else if( n == floor(width/2) ) return true;
  else return false;
}

boolean beforeMiddle(int w){
  if( w < floor(width/2) ) return true;
  else return false;
}

boolean isSameSide(PVector p1, PVector p2, PVector a, PVector b){
  PVector ba = PVector.sub(b, a);
  PVector p1a = PVector.sub(p1, a);
  PVector p2a = PVector.sub(p2, a);
  PVector cp1 = ba.cross( p1a );
  PVector cp2 = ba.cross( p2a );
  if(PVector.dot(cp1, cp2) >= 0) return true;
  else return false;
}

boolean isInsideTriangle(PVector p, PVector a, PVector b, PVector c){
  boolean one = isSameSide(p, a, b, c);
  boolean two = isSameSide(p, b, a, c);
  boolean three = isSameSide(p, c, a, b);
  if( one && two && three) return true;
  else return false;
}

boolean isInsideQuad(int x, int y){
  // Viereck in 2 Dreiecke teilen, 123, 134
  PVector p = new PVector(x, y);
  if( isInsideTriangle(p, q1, q2, q3) || isInsideTriangle(p, q1, q3, q4)) return true;
  else return false;
}

void draw(){
  q1 = new PVector(random(width/2, width), random(height/2));
  q2 = new PVector(random(width/2), random(height/2));
  q3 = new PVector(random(width/2), random(height/2, width));
  q4 = new PVector(random(width/2, width), random(height/2, width));
  
  loadPixels();
  img.loadPixels();
  for(int h = 0; h < height; h++){
    for(int w = 0; w < width; w++){
      int i = l(w, h);
      if( isInsideQuad(w, h) ){
        color c = img.pixels[i];
        pixels[i] = color(1-red(c), 1-green(c), 1-blue(c));
      }else{
        pixels[i] = img.pixels[i];
      }
    }
  }
  updatePixels();
  saveFrame("new#########.jpg");
}
