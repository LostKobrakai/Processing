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
  size(1280, 768, P3D);
  obj3d zylinder = new obj3d("quader");
  zylinder.addVertex(0,0,0);
  zylinder.addVertex(0,5,0);
  int segmente = 20;
  for(int i = 0; i < segmente; i++){
    float index = 1.0*i/segmente;
    float sin = sin(index*2*PI);
    float cos = cos(index*2*PI);
    beginShape();
    vertex(sin*100,0,cos*100);
    vertex(sin*100,5*100,cos*100);
    endShape();
    zylinder.addVertex(sin,0,cos);
    zylinder.addVertex(sin,5,cos);
    if(i==0){
      zylinder.addTriangle(1, 3, 3+(2*(segmente-1)));
      zylinder.addTriangle(2, 4, 4+(2*(segmente-1)));
      zylinder.addQuad(3, 4, 4+(2*(segmente-1)), 3+(2*(segmente-1)));
    }else{ 
      zylinder.addTriangle(1, 3+(2*i), 3+(2*(i-1)));
      zylinder.addTriangle(2, 4+(2*i), 4+(2*(i-1)));
      zylinder.addQuad(3+(2*i), 4+(2*i), 4+(2*(i-1)), 3+(2*(i-1)));
    }
  }
  saveStrings("zylinder.obj", zylinder.toStringArray());
}
