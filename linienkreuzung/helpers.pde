int lin(int x, int y){
  return y*width+x;
}

int[] delin(int i){
  int[] coords = {floor(i/width), i%width};
  return coords;
}

boolean checkCoords(int x, int y){
  if(x >= 0 && x < width && y >= 0 && y < height) return true;
  else return false;
}
