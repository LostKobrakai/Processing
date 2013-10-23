class Obj3D{
  PVector[][] faces;
  int index = 0;

  Obj3D(int len){
    faces = new PVector[len][3];
  }
  
  PVector[] getClosestVectors(PVector v){
    PVector v1;
    int index1;
    PVector v2;
    int index2;
    
    for(int i = 0; i < index; i++){
      if()
    }
  }
  
  void addVertex(int x, int y, int z){
    PVector tmp = new PVector(x, y, z);
    vertexes[index] = tmp;
    index++;
  }
  
  void addVertex(PVector v){
    vertexes[index] = v;
    index++;
  }
  
  void buildShape(){
    for(int i = 0; i < index; i++){
      vertex(vertexes[i].x, vertexes[i].y, vertexes[i].z);
    }
  }
  
  int getIndex(){
    return index;
  }
}
