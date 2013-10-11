void buildRect(int x, int y, int z){
  translate(x, y, z);
  fill(0,0,0, 1.0*z/500);
  rect(0,0,4,4);
  translate(-x, -y, -z);
}

int z;

void setup(){
  colorMode(RGB, 1);
  size(1250, 750, P3D);
  background(255,255,255);
  fill(0,0,0);
  noStroke();
  frameRate(10);
}

void draw(){
  translate(width/2, height/2);
  for(int turn  = 0; turn < 4; turn++){
    if(turn != 0) rotate(HALF_PI);
    for(int x = 10; x < 500; x+=30){
      for(int y = 10; y < 500; y+=30){
        buildRect(x, y, z);
      }
    }
  }
  z += 50;
}
