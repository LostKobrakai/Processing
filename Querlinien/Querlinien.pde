int radius;

void setup() {
  colorMode(HSB, 100);
  size(1280, 768);
  background(0, 0, 100);
  radius = 100;
  frameRate(20);
}

void draw() {
  int pX = pmouseX;
  int pY = pmouseY;
  int X = mouseX;
  int Y = mouseY;

  int deltaX = pX - X;
  int deltaY = pY - Y;

  float deltaP = sqrt(sq(deltaX)+sq(deltaY));
  float angle = asin(deltaX/deltaP);
  println(angle);
  float ndeltaX = 0;
  if(deltaX != 0) ndeltaX = sqrt(int(abs((1 - sq(deltaY/deltaX))/2)));
  //if(deltaX != 0) ndeltaX = deltaY/deltaX;
  
  if(ndeltaX != 0.0) println(sqrt(int(sq(ndeltaX)+sq(deltaY/deltaX*ndeltaX))));
  
  line(X+deltaY, Y-deltaX, X-deltaY, Y+deltaX);
}

