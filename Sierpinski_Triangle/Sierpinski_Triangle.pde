Turtle t;
float dist;

void setup(){
  size(720,720);
  colorMode(RGB, 1);
  t = new Turtle(width/2, height/2);
  frameRate(2);
  dist = 5.0;
}

void a(Turtle t, int n, int s){
  if( n == s) t.forward(dist);
  else{
    b(t, n, s+1);
    m(t, n, s+1);
    a(t, n, s+1);
    m(t, n, s+1);
    b(t, n, s+1);
  }
}

void b(Turtle t, int n, int s){
  if( n == s) t.forward(dist);
  else{
    a(t, n, s+1);
    p(t, n, s+1);
    b(t, n, s+1);
    p(t, n, s+1);
    a(t, n, s+1);
  }
}

void p(Turtle t, int n, int s){
  if( n == s) t.left(60);
  else{
    p(t, n, s+1);
  }
}

void m(Turtle t, int n, int s){
  if( n == s) t.right(60);
  else{
    m(t, n, s+1);
  }
}

void draw(){
  background(1,1,1);
  t.reset(width/2, height/2);
  dist = dist * 3/5;
  a(t, frameCount*2, 0);
}
