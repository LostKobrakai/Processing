class Steps
{
  int current;
  int[] steps;
  
  Steps(int c, int[] s){
    current = c;
    steps = s;
  }
  
  int getCurrent(){
    return current;
  }
  
  int[] getSteps(){
    return steps;
  }
}
