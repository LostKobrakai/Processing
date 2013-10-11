int[] shift;
int active;
PImage img;

void setup() {
  img = loadImage("5.jpg");
  size(img.width/3*2, img.height/3*2);
  image(img, 0, 0, width, height);
  active = 0;
  shift = new int[]{0,0,0};
}

void keyPressed(){
  if(keyCode == 38) changeActive(false); // 37-40, links, hoch, rechts, runter
  if(keyCode == 40) changeActive(true);
  if(keyCode == 37) shift[active]--;
  if(keyCode == 39) shift[active]++;
  loop();
}

void changeActive(boolean down){
  if(down){
    if(active+1 <= 3) active++;
  }else{
    if(active-1 >= 0) active--;
  }
}

void drawSlider(int x, int y, int l, int pos, boolean act){
  if(act){
    pushStyle();
    stroke(255,255,255);
  }
  line(x,y,x+l,y);
  line(x+l/2+pos,y-1,x+l/2+pos,y+1);
  if(act) popStyle();
}

void draw() {
  PImage img2;
  img2 = img;
  img2.loadPixels();
  for(int i = 0; i < img2.width*img2.height; i++){
    if(i == 300) println(red(img2.pixels[i]));
    float red = red(img2.pixels[i]+shift[0]);
    float green = green(img2.pixels[i])+shift[1];
    float blue = blue(img2.pixels[i])+shift[2];
    img2.pixels[i] = color(red,green,blue);
  }
  img2.updatePixels();
  image(img2, 0, 0, width, height);
  for(int i = 0; i < 3; i++){
    if(i == active) drawSlider(10,10+10*i,50,shift[i], true);
    else drawSlider(10,10+10*i,50,shift[i], false);
  }
  noLoop();
}

