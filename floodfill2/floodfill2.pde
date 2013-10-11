int diff;
int px;
color fillC;
color test;
ArrayList<int[]> stack;

void setup()
{
  size(750, 400);
  stroke(255,0,0);
  noFill();
  stack = new ArrayList<int[]>();
  px = width*height;
  fillC = color(255,0,0);
  diff = 50;
}

int l(int x, int y){
  return x + (y * width);
}

boolean cCoords(int[] coords){
  if(coords[0] >= 0 && coords[0] < width && coords[1] >= 0 && coords[1] < height ) return true;
  else return false;
}

color[] flood(int x, int y, color[] pixel){
  int[] coords = {x, y};
  stack.add(coords);
  
  while(stack.size() > 0){
    coords = stack.get(stack.size() - 1);
    stack.remove(stack.size() - 1);
    
    float rt = red(test);
    float gt = green(test);
    float bt = blue(test);
    
    float rc = red(pixel[l(coords[0], coords[1])]);
    float gc = green(pixel[l(coords[0], coords[1])]);
    float bc = blue(pixel[l(coords[0], coords[1])]);
    
    if(dist(rt, gt, bt, rc, gc, bc) <= diff){
      pixel[l(x, y)] = fillC;
      
      coords[0]++;
      if(cCoords(coords)) stack.add(coords);
      
      coords[0] -= 2;
      println("First");
      println(coords);
      if(cCoords(coords)) stack.add(coords);
      
      coords[0]++;
      coords[1]++;
      if(cCoords(coords)) stack.add(coords);
      
      coords[1] -= 2;
      println("Second");
      println(coords);
      if(cCoords(coords)) stack.add(coords);
    }
  }
  return pixel;
}

void draw() {
  rect(5, 5, 50, 50);
  if(mousePressed){
    loadPixels();
    
    test = pixels[l(mouseX, mouseY)];
    pixels = flood(mouseX, mouseY, pixels);
    
    updatePixels();
  }
}
