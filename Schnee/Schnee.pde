void setup(){
  size(1280, 720);
  colorMode(RGB, 1);
  background(1);
  
  //Kugeln erstellen
  for(int i = floor(random(10)); i >= 0; i--){
    pushStyle();
    fill(0);
    noStroke();
    float x = map(random(1), 0, 1, 30, width-30);
    float y = map(random(1), 0, 1, 30, height-30);
    ellipse(x, y, random(30), random(30));
    popStyle();
  }
  
}

int lin(int x, int y){
  return x + (y * width);
}

void draw(){
  loadPixels();
  
  //Schnee fallen lassen
  for(int h = (height - 1); h >= 0; h--){
    for(int w = 0; w < width; w++){
      int i = lin(w, h);
      if(i >= width*height - 10) println(i+width);
      if(pixels[i] == color(0) && i+width < width*height){
        if( pixels[i + width] != color(0) ){
          pixels[i] = color(1);
          pixels[i + width] = color(0);
        }else if( pixels[i + width - 1 ] != color(0) && i+width+1 < width*height && pixels[i + width + 1 ] != color(0) ){
          if(random(1) < 0.5){
            pixels[i] = color(1);
            pixels[i + width - 1] = color(0);
          }else{
            pixels[i] = color(1);
            pixels[i + width + 1] = color(0);
          }
        }else if( pixels[i + width - 1 ] != color(0) ){
          pixels[i] = color(1);
          pixels[i + width - 1] = color(0);
        }else if( i+width+1 < width*height && pixels[i + width + 1 ] != color(0)){
          pixels[i] = color(1);
          pixels[i + width + 1] = color(0);
        }
      }
    }
  }
  
  //Neuer Schnee
  for(int i = 0; i < width; i++){
    if(random(1) <= .05) pixels[i] = color(0);
  }
  
  updatePixels();
}
