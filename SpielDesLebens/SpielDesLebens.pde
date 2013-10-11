color live;
color dead;
int maxPixel;
boolean[] cells;

void setup(){
 colorMode(RGB, 1);
 size(500, 500);
 background(1,1,1);
 frameRate(5);
 
 live = color(0,0,0);
 dead = color(1,1,1);
 maxPixel = width*height;
 cells = new boolean[maxPixel];
 stroke(live);
 
 loadPixels();
 for(int i = 0; i < maxPixel; i++){
   if(random(1) > 0.5) pixels[i] = live;
   //pixels[int(random(maxPixel))] = live;
 }
 updatePixels();
 point(1, 3);
 point(2, 3);
 point(3, 3);
}

boolean checkLiving(int[] p, int x, int y){
  boolean living = checkLive(p[x + y * 500]);
  int count = 0;
  
  //Bsp: x = 1, y = 1;
  if(checkCoord( x - 1, y ) && checkLive(p[(x - 1) + y * 500])) count++;
  if(checkCoord( x + 1, y ) && checkLive(p[(x + 1) + y * 500])) count++;
  if(checkCoord( x - 1, y - 1 ) && checkLive(p[(x - 1) + (y - 1) * 500])) count++;
  if(checkCoord( x + 1, y - 1 ) && checkLive(p[(x + 1) + (y - 1) * 500])) count++;
  if(checkCoord( x,     y - 1 ) && checkLive(p[x + (y - 1) * 500])) count++;
  if(checkCoord( x - 1, y + 1 ) && checkLive(p[(x - 1) + (y + 1) * 500])) count++;
  if(checkCoord( x + 1, y + 1 ) && checkLive(p[(x + 1) + (y + 1) * 500])) count++;
  if(checkCoord( x,     y + 1 ) && checkLive(p[x + (y + 1) * 500])) count++;
    
  if(count <= 3 && count >= 2){
    if(living) return true;
    else if(!living && count == 3) return true;
    else return false;
  }else return false;
}

boolean checkCoord(int x, int y){
  if(x >= 0 && x < width && y >= 0 && y < height) return true;
  else return false;
}

boolean checkLive(color checkColor){
  if(checkColor != dead) return true;
  else return false;
}

void draw(){
  loadPixels();
  for(int y = 0; y < height; y++){
     for(int x = 0; x < width; x++){
       int target = x + (y * 500);
       if( checkLiving(pixels, x, y) ) cells[target] = true;
       else cells[target] = false;
     }
  }
  for(int i = 0; i < maxPixel; i++){
    if(cells[i]) pixels[i] = live;
    else pixels[i] = dead;
  }
  updatePixels();
}
