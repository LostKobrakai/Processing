PImage img;
AnimateDots a;
float[][] p;

int lin(int x, int y){
  return y * width + x;
}

void setup(){
  colorMode(RGB, 1);
  background(0, 0, 0);
  noFill();
  strokeWeight(3);
  
  img = loadImage("lara.jpg");
  size(img.width, img.height); 

  a = new AnimateDots(img);
}

void animate(AnimateDots a){
  int[] dim = a.getDim();
  for(int w = 0; w < dim[0]; w++){
    float angleW = TAU / dim[0] /2 * w;
    for(int h = 0; h < dim[1]; h++){
      float angleH = TAU / dim[1] * h;
      a.addY(lin(w, h), sin(angleW)*sin(angleH)*30);
    }
  }
}

void draw(){
  int t = frameCount;
  background(0, 0, 0);
  
  //animate(a);
  
  for(int x = 0; x < img.width; x++){
    for(int y = 0; y < img.height; y++){
      if(x != 0 || y != 0){
        int i = lin(x,y);
        //Rot
        if(x%6 == 0 && y%5 == 0){
          float speed = (sin(noise(i, 0)) - 0.5) * 5;
          a.addY(i, speed);
          speed = (sin(noise(i, .3)) - 0.5) * 3;
          a.addX(i, speed);
          strokeWeight(a.getRed(i) * 5);
          stroke(1, 0, 0);
          point(a.getX(i), a.getY(i));
        }
        
        //Grün
        if(x%6 == 3 && y%5 == 3){
          float speed = (sin(noise(i, .7)) - 0.5) * 5;
          a.addY(i, speed);
          speed = (sin(noise(i, .4)) - 0.5) * 3;
          a.addX(i, speed);
          strokeWeight(a.getGreen(i) * 5);
          stroke(0, 1, 0);
          point(a.getX(i), a.getY(i));
        }
        
        //Blau
        if(x%6 == 4 && y%5 == 1){
          float speed = (sin(noise(i, .9)) - 0.5) * 5;
          a.addY(i, speed);
          speed = (sin(noise(i, .8)) - 0.5) * 3;
          a.addX(i, speed);
          strokeWeight(a.getBlue(i) * 5);
          stroke(0, 0, 1);
          point(a.getX(i), a.getY(i));
        }
      }
    }
  }
  
  //noLoop();
  saveFrame("lara_"+hour()+"_"+minute()+"_#####.png");
}

void mousePressed(){
  loop();
}
