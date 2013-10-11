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
  size(1280,768);
  obj3d sphere = new obj3d("sphere");
  float mX = 0; //Mittelpunkt
  float mZ = 0; //Mittelpunkt
  int segmenteV = 10; //Vertikal
  int segmenteH = 10; //Horizontal
  float radius = 5;
  
  sphere.addVertex(mX,radius,mZ);
  sphere.addVertex(mX,-radius,mZ);
  
  for(int v = 0; v < segmenteV; v++){
    float segV = radius - v*radius*2/segmenteV; 
    float angleV = float(v)/segmenteV/2; 
    
    for(int h = 0; h < segmenteH; h++){
      int lastSegH = (h - 1 + segmenteH) % segmenteH;
      float angleH = float(h)/segmenteH;
      float x = sin(angleV*TAU) * cos(angleH*TAU);
      float y = sin(angleV*TAU);
      float z = sin(angleV*TAU) * sin(angleH*TAU);
      
      sphere.addVertex(x*radius,y*radius,z*radius);
      
      //println(v+" "+h+": "+x+" "+y+" "+z+" "+angleV);
      if(v==0){
        sphere.addTriangle(1, 3+h, 3+lastSegH);
      }else if(v==segmenteV-1){
        sphere.addTriangle(2, 3+h+(segmenteV*(v)), 3+lastSegH+(segmenteV*(v)));
        sphere.addQuad(3+h+(v*segmenteV), 3+lastSegH+(segmenteV*v), (segmenteV*(v-1))+3+lastSegH, (segmenteV*(v-1))+3+h);
      }else{
        println((h+(v*segmenteV))+" "+(lastSegH+(segmenteV*v))+" "+((segmenteV*(v-1))+lastSegH)+" "+((segmenteV*(v-1))+h));
        sphere.addQuad(3+h+(v*segmenteV), 3+lastSegH+(segmenteV*v), (segmenteV*(v-1))+3+lastSegH, (segmenteV*(v-1))+3+h);
      }
    }
  }
  saveStrings("sphere.obj", sphere.toStringArray());
}
