Obj3D obj;
int l;

void buildIco(float r){
  // create 12 vertices of a icosahedron
  
  float t = (1.0 + sqrt(5.0)) / 2.0 * r;
  float u = 1 * r;
  
  PVector p0 = new PVector(-u,  t,  0);
  PVector p1 = new PVector( u,  t,  0);
  PVector p2 = new PVector(-u, -t,  0);
  PVector p3 = new PVector( u, -t,  0);
  
  PVector p4 = new PVector( 0, -u,  t);
  PVector p5 = new PVector( 0,  u,  t);
  PVector p6 = new PVector( 0, -u, -t);
  PVector p7 = new PVector( 0,  u, -t);
  
  PVector p8 = new PVector( t,  0, -u);
  PVector p9 = new PVector( t,  0,  u);
  PVector p10 = new PVector(-t,  0, -u);
  PVector p11 = new PVector(-t,  0,  u);
  
  obj.addFace(p0, p11, p5);
  obj.addFace(p0, p5, p1);
  obj.addFace(p0, p1, p7);
  obj.addFace(p0, p7, p10);
  obj.addFace(p0, p10, p11);
  
  obj.addFace(p1, p5, p9);
  obj.addFace(p5, p11, p4);
  obj.addFace(p11, p10, p2);
  obj.addFace(p10, p7, p6);
  obj.addFace(p7, p1, p8);
  
  obj.addFace(p3, p9, p4);
  obj.addFace(p3, p4, p2);
  obj.addFace(p3, p2, p6);
  obj.addFace(p3, p6, p8);
  obj.addFace(p3, p8, p9);
  
  obj.addFace(p4, p9, p5);
  obj.addFace(p2, p4, p11);
  obj.addFace(p6, p2, p10);
  obj.addFace(p8, p6, p7);
  obj.addFace(p9, p8, p1);
}

void setup(){
  size(1280, 720, P3D);
  colorMode(RGB, 1);
  fill(.5, .5, .5 , .5);
  strokeWeight(3);
  stroke(0);
  obj = new Obj3D(10000);
  
  buildIco(100);
  obj.test();
}

void draw(){
  background(1);
  
  translate(width/2, height/2);
  rotateY(radians((frameCount+360)%360));
  rotateX(radians(((frameCount / 4)+360)%360));
  obj.buildFaces();
  obj.buildFace(l);
}

void mousePressed(){
  l++;
}
