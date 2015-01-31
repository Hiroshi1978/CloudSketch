void drawImages(){
  synchronized(lock){
    displayZones(width,height);
    displayLoadBalancers();
    displayHealthChecks();
  }
}

void displayZones(float w, float h){
  
  float frameSizeX = w/zImages.size();
  float frameSizeY;
  float zFrameYloc;
  
  if(lbs.isEmpty()){
    frameSizeY = h;
    zFrameYloc = 0;
  }else{
    frameSizeY = h * 0.7;
    zFrameYloc = height * 0.3;
  }
  
  List<ZoneImage> images = new ArrayList<ZoneImage>(zImages.values());
  for(int i=0; i<images.size(); i++){
    ZoneImage z = images.get(i);
    z.display(i*frameSizeX, zFrameYloc, frameSizeX, frameSizeY);
    displayInstances(z);
  }  
}

void displayInstances(ZoneImage z){
  
  List<InstanceImage> images = new ArrayList<InstanceImage>(instancesOfZone.get(z));
  
  float w            = z.getW();
  float h            = z.getH();
  float xloc         = z.getXloc();
  float yloc         = z.getYloc();
  
  float rwh          = w/h;
  int insNum         = iImages.size();
  int insRowNumMax   = 4;
  int insRowNum      = 
    insNum < insRowNumMax ? insNum : insRowNumMax;    
  int insColNum =     
    (insNum % insRowNum) == 0 ? insNum/insRowNum : insNum/insRowNum + 1;
  float insFrameSizeX = w/insRowNum;
  float insFrameSizeY = h/insColNum;
  
  for(int i=0; i<images.size(); i++){
    
    InstanceImage ins = images.get(i);
    if(ins.getZone().equals(z.getName())){
      ins.setFrame( xloc + (i%insRowNum) * ins.getFrameSizeX(),
                    yloc + (i/insRowNum) * ins.getFrameSizeY(),
                    insFrameSizeX,
                    insFrameSizeY                               );
      ins.display();
    }
  }
  
}

void displayLoadBalancers(){
  for(LoadBalancerImage lb : lImages.values()){
    Set<ZoneImage> zs = zonesOfLb.get(lb);
    lb.display(0,0,width,height*0.3,new ArrayList<ZoneImage>(zs));
  }
}

void displayHealthChecks(){
  for(HealthCheckImage hc : hcImages)
    hc.updateAndDisplay();
}

