import processing.video.*;
Capture cap;

class obj3d{
  String name;
  float[][] vertexes;
  int[][] faces;
  
  obj3d(String newName, int w, int h){
    name = newName;
    vertexes = new float[w*h+1][3];
    faces = new int[(w-1)*(h-1)*2][3];
  }
  
  String[] toStringArray(){
    int vl = vertexes.length;
    int fl = faces.length;
    int l = 1 + vl + fl;
    String[] data = new String[l]; 
    data[0] = "o "+name;
    for(int i = 0; i < vl; i++){
      data[i+1] = "v "+str(vertexes[i][0])+" "+str(vertexes[i][1])+" "+str(vertexes[i][2]);
    }
    for(int i = 0; i < fl; i++){
      data[i+vl+1] = "f "+str(faces[i][0])+" "+str(faces[i][1])+" "+str(faces[i][2]);
    }
    return data;
  }
  
  void addVertex(int i, float x, float y, float z){
    float[] vertex = {x, y, z};
    vertexes[i] = vertex;
  }
    
  void addTriangle(int i, int a, int b, int c){
    int[] triangle = {a, b, c};
    faces[i] = triangle;
  }
  
  void addQuad(int i, int a, int b, int c, int d){
    this.addTriangle(i*2,a,b,c);
    this.addTriangle(i*2+1,a,c,d);
  }
}

obj3d face;

void setup()
{
  size(1280, 720);
  cap = new Capture(this, width, height, 30);
  cap.start();
  noStroke();
  
  face = new obj3d("face", width, height);
}

void draw() {
  if(cap.available() == true){
    
    cap.read();
    
    if(mousePressed){
      image(cap, 0, 0, width, height);
      saveFrame("image"+frameCount+".png");
    }
    
    cap.loadPixels();
    
    for(int h = 0; h < height; h++){
      for(int w = 0; w < width; w++){
        int i = h*width+w;
        float brightness = brightness(cap.pixels[i]);
        cap.pixels[i] = color(brightness, brightness, brightness);
        
        float x = w+1 - (width/2);
        float y = -h+1 + (height/2);
        float z = brightness / 10;
        
        face.addVertex(i, x, y, z);
        if(w != 0 && h != 0){
          int iF = ((h-1)*(width-1))+(w-1);
          face.addQuad(iF, 1+i, i, i-width, 1+i-width);
        }
      }
    }
    
    cap.updatePixels();
    
    if(mousePressed){
      saveStrings("face"+frameCount+".obj", face.toStringArray());
      println("saved");
    }
    
    image(cap, 0, 0, width, height);
  }
}

