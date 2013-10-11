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
  
  void addQuad(int a, int b, int c, int d){
    this.addTriangle(a,b,c);
    this.addTriangle(a,c,d);
  }
}

StringList obj;

void setup() {
  obj3d sphere = new obj3d("quader");
  float mX = 0; //Mittelpunkt
  float mZ = 0; //Mittelpunkt
  int segmenteV = 20; //Vertikal
  int segmenteH = 10; //Horizontal
  float radius = 2;
  
  sphere.addVertex(mX,radius,mZ);
  sphere.addVertex(mX,-radius,mZ);
  
  for(int v = 0; v < segmenteV; v++){
    for(int h = 0; h < segmenteH; h++){
      float x = radius * cos(h*HALF_PI-PI) * cos(v*TAU);
      float y = radius * cos(h*HALF_PI-PI) * sin(v*TAU);
      float z = radius * sin(h*HALF_PI-PI);
      
      sphere.addVertex(x,y,z); //(0,1.9,0.6);
    }
  }
  saveStrings("sphere.obj", sphere.toStringArray());
}
