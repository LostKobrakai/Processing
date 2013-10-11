class obj3d{
  String name;
  ArrayList<float[]> vertexes;
  ArrayList<int[]> faces;
  
  obj3d(String newName){
    name = newName;
    vertexes = new ArrayList<float[]>();
    faces = new ArrayList<int[]>();
  }
  
  String[] toStringArray(){
    int vl = vertexes.size();
    int l = 1 + vl + faces.size();
    String[] data = new String[l]; 
    data[0] = "o "+name;
    for(int i = 0; i < vl; i++){
      data[i+1] = "v "+str(vertexes.get(i)[0])+" "+str(vertexes.get(i)[1])+" "+str(vertexes.get(i)[2]);
    }
    for(int i = 0; i < faces.size(); i++){
      data[i+vl+1] = "f "+str(faces.get(i)[0])+" "+str(faces.get(i)[1])+" "+str(faces.get(i)[2]);
    }
    return data;
  }
  
  void addVertex(float x, float y, float z){
    float[] vertex = {x, y, z};
    vertexes.add(vertex);
  }
    
  void addTriangle(int a, int b, int c){
    int[] triangle = {a, b, c};
    faces.add(triangle);
  }
  
  void addSquare(int a, int b, int c, int d){
    this.addTriangle(a,b,c);
    this.addTriangle(a,c,d);
  }
}

StringList obj;

void setup() {
  obj3d quader = new obj3d("quader");
  quader.addVertex(3.0, 5.0, 5.0);
  quader.addVertex(3.0, 10.0, 5.0);
  quader.addVertex(4.0, 5.0, 5.0);
  quader.addVertex(4.0, 10.0, 5.0);
  quader.addVertex(3.0, 5.0, 10.0);
  quader.addVertex(3.0, 10.0, 10.0);
  quader.addVertex(4.0, 5.0, 10.0);
  quader.addVertex(4.0, 10.0, 10.0);
  quader.addSquare(1,2,4,3);
  quader.addSquare(5,6,8,7);
  quader.addSquare(1,2,6,5);
  quader.addSquare(3,4,8,7);
  quader.addSquare(2,4,8,6);
  quader.addSquare(1,3,7,5);
  saveStrings("quader.obj", quader.toStringArray());
}
