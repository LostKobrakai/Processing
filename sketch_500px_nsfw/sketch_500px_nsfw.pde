JSONArray photos;

void setup(){
  photos = loadJSONArray("data.json");
  
  int nsfw = 0;
  int sfw = 0;
  String url = new String();
  size(450, 210);
  colorMode(RGB, 1);
  background(1);
  noStroke();
  
  for(int i = 0; i < photos.size(); i++){
    
    int x = (i * 9 + width) % width;
    int y = floor((i * 9) / width);
    
    JSONObject photo = photos.getJSONObject(i);
    if(photo.getBoolean("nsfw") == true){
      fill(photo.getInt("rating")*1.0/100);
      rect(x, y, 3, 3);
      
      nsfw++;
    }else{
      sfw++;
    }
  }
}

void draw(){  
}
