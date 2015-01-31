void drawNowChanging(){
  String message = "Now Changing ...";
  textSize(32);
  textAlign(CENTER,CENTER);
  if(changingMessageLocation > 1000)
    changingMessageLocation = -1000;
  changingMessageLocation += 20;
  for(int i=2; i>=0;i--){
    float zLocation = changingMessageLocation - 2000 * i;
    float cordination = 100;
    float o = 204 - zLocation + cordination;
    fill(0, 102, 153, o);
    text(message, width/2, height/2, zLocation);
  }
}

void drawTexts(){
  
  textOfLbs();
  textOfZones();
  textOfInstances();  
}

void textOfLbs(){
  textSize(12);
  fill(0);
  textAlign(CENTER,TOP);
  for(LoadBalancerImage l : lImages.values())
    text(l.getName(), l.getXlocFrame() + l.getFrameSizeX()/2, l.getYlocFrame() + 20, 0);
}

void textOfZones(){
  textSize(12);
  fill(0);
  textAlign(LEFT,BOTTOM);
  for(ZoneImage z : zImages.values())
    text(z.getName(), z.getXloc(), z.getYloc() - 5, 0);
}

void textOfInstances(){
  textSize(12);
  fill(0);
  textAlign(CENTER,BOTTOM);
  for(InstanceImage i : iImages.values()){
    String t = i.getIp();
    text(t, i.getXlocFrame() + i.getFrameSizeX()/2, i.getYlocFrame() + i.getFrameSizeY(), 0);
  }
}

