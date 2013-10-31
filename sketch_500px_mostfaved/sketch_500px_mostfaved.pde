import java.util.Iterator;

JSONArray photos;
JSONObject mostfaved;
int biggest;

void setup(){
  photos = loadJSONArray("data.json");
  mostfaved = new JSONObject();

  size(displayWidth/2, displayHeight);
  colorMode(RGB, 1);
  background(1);
  noStroke();
  fill(0);
  biggest = 0;
  
  for(int i = 0; i < photos.size(); i++){
    JSONObject photo = photos.getJSONObject(i);
    JSONObject user = photo.getJSONObject("user");
    String uid = user.getString("username");
    
    if(mostfaved.hasKey(uid)){
      JSONObject photos = mostfaved.getJSONObject(uid); 
      JSONArray fav = photos.getJSONArray("photos"); 
      int newCount = photos.getInt("count") + 1;
      if(newCount > biggest) biggest = newCount;
      fav.append(photo.getString("image_url"));
      
      photos.setJSONArray("photos", fav);
      photos.setInt("count", newCount);
      mostfaved.setJSONObject(uid, photos);
    }else{
      JSONArray fav = new JSONArray();
      fav.append(photo.getString("image_url"));
      JSONObject photos = new JSONObject();
      photos.setJSONArray("photos", fav);
      photos.setInt("count", 1);
      mostfaved.setJSONObject(uid, photos);
    }
  }
  println(biggest);
  int j = 0;
  for(int i = biggest; i > 0; i--){
    int x = width/biggest * j;
    int y = height/2;
    
    int count = 0;
    Iterator iter = mostfaved.keyIterator();
    while(iter.hasNext()){
      JSONObject user = mostfaved.getJSONObject(iter.next().toString());
      if(user.getInt("count") == i) count ++;
    }
    rect(x, y, i, count);
    println();
    j++;
  }
}

void draw(){  
}
