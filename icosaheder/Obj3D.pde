class Obj3D{
  PVector[][] faces;
  int index = 0;
  
  Obj3D(int len){
    faces = new PVector[len][3];
  }
  
  void addFace(PVector a, PVector b, PVector c){
    faces[index][0] = a;
    faces[index][1] = b;
    faces[index][2] = c;
    index++;
  }
  
  void buildFaces(){
    pushStyle();
    noFill();
    beginShape();
    for(int i = 0; i < index; i++){
      vertex(faces[i][0].x, faces[i][0].y, faces[i][0].z);
      vertex(faces[i][1].x, faces[i][1].y, faces[i][1].z);
      vertex(faces[i][2].x, faces[i][2].y, faces[i][2].z);
    }
    endShape(CLOSE);
    popStyle();
  }
  
  void buildFace(int i){
    i = i%index;
    beginShape();
    vertex(faces[i][0].x, faces[i][0].y, faces[i][0].z);
    vertex(faces[i][1].x, faces[i][1].y, faces[i][1].z);
    vertex(faces[i][2].x, faces[i][2].y, faces[i][2].z);
    endShape(CLOSE);
  }
  
  void test(){
    for(int i = 0; i < index; i++){
      println("---------------- "+i+" ----------------");
      println(PVector.dist(faces[i][0], faces[i][1]));
      println(PVector.dist(faces[i][1], faces[i][2]));
      println(PVector.dist(faces[i][2], faces[i][0]));
    }
  }
}
