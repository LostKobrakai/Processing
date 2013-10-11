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
  
  void addVertex(PVector v){
    float[] vertex = v.array();
    int index = vertexes.indexOf(vertex);
  }
  
  int getVertexIndex(PVector v){
    float[] vertex = v.array();
    return vertexes.indexOf(vertex) + 1;
  }
    
  void addTriangle(int a, int b, int c){
    int[] triangle = {a, b, c};
    faces.add(triangle);
  }
  
  void addQuad(int a, int b, int c, int d){
    this.addTriangle(a,b,c);
    this.addTriangle(a,c,d);
  }
}
