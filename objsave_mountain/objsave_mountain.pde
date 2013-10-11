obj3d mp_rep(obj3d m, int n, PVector v1, PVector v2, PVector v3){
  PVector a = PVector.sub(v1, v2);
  PVector b = PVector.sub(v2, v3);
  PVector c = PVector.sub(v3, v1);
  
  PVector v01 = PVector.add(v2, PVector.div(a, 2));
  PVector v02 = PVector.add(v3, PVector.div(b, 2));
  PVector v03 = PVector.add(v1, PVector.div(c, 2));
  
  PVector[] shift = new PVector[3];
  
  for(int i = 0; i < 3; i++){
    shift[i] = new PVector(0, 1<<n, 0);
  }
  
  v01.add(shift[0]);
  v02.add(shift[1]);
  v03.add(shift[2]);
  
  m.addVertex(v01);
  m.addVertex(v02);
  m.addVertex(v03);
  
  n--;
  
  if(n<=0){
    int[] indexes = {m.getVertexIndex(v1), 
                     m.getVertexIndex(v2), 
                     m.getVertexIndex(v3), 
                     m.getVertexIndex(v01),
                     m.getVertexIndex(v02),
                     m.getVertexIndex(v03)};
    m.addTriangle(indexes[0], indexes[3], indexes[5]);
    m.addTriangle(indexes[1], indexes[3], indexes[4]);
    m.addTriangle(indexes[2], indexes[4], indexes[5]);
    m.addTriangle(indexes[3], indexes[4], indexes[5]);
    return m;
  }else{
    m = mp_rep(m, n, v1, v01, v03);
    m = mp_rep(m, n, v2, v01, v02);
    m = mp_rep(m, n, v3, v02, v03);
    m = mp_rep(m, n, v01, v02, v03);
  }
  
  return m;
}

void setup() {
  size(1280,768);
  obj3d mount = new obj3d("mountain");
  PVector v1 = new PVector(0, 0, 256);
  PVector v2 = new PVector(0, 0, 0);
  PVector v3 = new PVector(256, 0, 0);
  
  mount.addVertex(v1);
  mount.addVertex(v2);
  mount.addVertex(v3);
  
  mount = mp_rep(mount, 5, v1, v2, v3);
  
  saveStrings("mountain"+frameCount+".obj", mount.toStringArray());
}
