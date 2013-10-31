PImage img;
int max;
int start;
int speed;

void setup(){
  img = loadImage("image4.jpg");
  size(img.width, img.height, P2D);
  smooth(4);
  colorMode(RGB, 1);
  background(1);
  stroke(0);
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

void draw(){
  loadPixels();
  img.loadPixels();
  for(int h = 0; h < height; h++){
    for(int w = 0; w < width; w++){
      int i = l(w, h);
      if( !isOdd(w) ){
        pixels[i] = img.pixels[i];
      }else if( isMiddle(w) ){
        pixels[i] = img.pixels[i];
      }else if( beforeMiddle(w) ){
        if( !isOdd(width) ) pixels[i] = img.pixels[ l(-w, h+1) ];
        else pixels[i] = img.pixels[ l(-w-1, h+1) ];
      }else if( !beforeMiddle(w) ){
        if( !isOdd(width) ) pixels[i] = img.pixels[ l(-w, h+1) ];
        else pixels[i] = img.pixels[ l(-w-1, h+1) ];
      }
    }
  }
  updatePixels();
  saveFrame("new.jpg");
  noLoop();
}
