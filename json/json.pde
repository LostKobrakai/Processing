JSONArray photos;

void setup(){
  photos = loadJSONArray("data.json");
  
  int nsfw = 0;
  int sfw = 0;
  String url = new String();
  size(150, 68);
  
  loadPixels();
  
  for(int i = 0; i < photos.size(); i++){
    JSONObject photo = photos.getJSONObject(i);
    if(i == 0){
      url = photo.getString("image_url");
    }
    if(photo.getBoolean("nsfw") == true){
      nsfw++;
    }else{
      sfw++;
    }
  }
  PImage img = loadImage(url);
  size(img.width/2, img.height/2);
  image(img, 0, 0, width, height);
  println(nsfw+" "+sfw);
  

}

void draw(){  
}
