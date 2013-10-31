class Wave{
  int bitrate;
  PVector[] wavedata;
  
  Wave(int len){
    bitrate = len;
    wavedata = new PVector[len];
    for(int i = 0; i < len; i++){
      PVector v = new PVector(0,0);
      wavedata[i] = v;
    }
  }
  
  void saveWavePoint(int i, PVector v){
     wavedata[i] = v;
  }
  
  void saveWavePoint(int i, float x, float y){
    PVector v = new PVector(x, y);
    wavedata[i] = v;
  }
  
  void saveWavePoints(PVector[] a){
    wavedata = a;
  }
  
  PVector[] getWavePoints(){
    return wavedata;
  }
  
  PVector getWavePoint(int i){
    return wavedata[i];
  }
}
