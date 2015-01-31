void setupResouces(){
  initResources();
}

void initResources(){
  zones     = factory.getZones();
  vpcs      = factory.getVPCs();
  subnets   = factory.getSubnets();
  lbs       = factory.getLoadBalancers();
  instances = factory.getInstances();
  //printInsCount();
}

void startInstanceMemberChecker(){

  Runnable r = new Runnable(){
    public void run(){
      while(true){
        try{
          Thread.sleep(10 * 1000);          
        }catch(Exception e){
        }
        if(insMemberChanged()){
          nowChanging = true;
          resetWindow();
          try{
            Thread.sleep(6000);          
          }catch(Exception e){
          }
          nowChanging = false;
        }
      }
    }
  };
  
  pool2.submit(r);
}

boolean insMemberChanged(){
  List<String> previousInsIds = new ArrayList<String>(iImages.keySet());
  List<String> latestInsIds = new ArrayList<String>();
  List<Instance> latestInstances   = factory.getInstances();
  for(Instance ins : latestInstances){
    latestInsIds.add(ins.getId());
  }
  Collections.sort(previousInsIds);
  Collections.sort(latestInsIds);
  if(latestInsIds.size() != previousInsIds.size())
    return true;
  for(int i=0;i<latestInsIds.size();i++){
    String p = previousInsIds.get(i);
    String l = latestInsIds.get(i);
    if(!l.equals(p))
      return true;
  }
  return false;
}

void resetWindow(){
  println("reset window start --");
  pool.shutdownNow();
  setupThreadPool();
  setupResouces();
  setupImages();
  println("reset window end   --");
}

void printInsCount(){
  Runnable r = new Runnable(){
    public void run(){
      while(true){
        try{
          Thread.sleep(1000);
          println(instances.size());
        }catch(Exception e){
        }
      }
    }
  };
  pool.submit(r);
}
