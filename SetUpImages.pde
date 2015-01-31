void setupImages(){
  
  synchronized(lock){
    initImages();
  
    setupZones();
    setupInstances();
    setupLoadBalancers();
    mappingInstancesToZones();
    mappingZonesToLbs();
    mappingInstancesToLb();
  
    setupHealthChecks();
  }
}

void initImages(){
  zImages         = new HashMap<String,ZoneImage>();
  iImages         = new HashMap<String,InstanceImage>();
  lImages         = new HashMap<String,LoadBalancerImage>();
  hcImages        = new ArrayList<HealthCheckImage>();

  instancesOfZone = new HashMap<ZoneImage,Set<InstanceImage>>();
  zonesOfLb       = new HashMap<LoadBalancerImage,Set<ZoneImage>>();
  instancesOfLb   = new HashMap<LoadBalancerImage,Set<InstanceImage>>();
}

void setupZones(){
  for(Zone z : zones){
    ZoneImage image = new ZoneImage(z);
    zImages.put(z.getName(),image);
  }
}


void setupInstances(){
  for(Instance i : instances){
    InstanceImage image = new InstanceImage(i);
    iImages.put(i.getId(),image);
  }
}
void setupLoadBalancers(){
  for(LoadBalancer lb : lbs){
    LoadBalancerImage image = new LoadBalancerImage(lb);
    lImages.put(lb.getName(),image);
  }
}

void mappingInstancesToZones(){
  for(ZoneImage z : zImages.values()){
    Set<InstanceImage> inses = new HashSet<InstanceImage>();
    for(InstanceImage i : iImages.values())
      if(z.getName().equals(i.getZone()))
        inses.add(i);
    instancesOfZone.put(z,inses);
  }
}

void mappingZonesToLbs(){
  for(LoadBalancerImage lb : lImages.values()){
    Set<ZoneImage> zs = new HashSet<ZoneImage>();
    for(ZoneImage z : zImages.values())
      if(lb.getZoneNames().contains(z.getName()))
        zs.add(z);
    zonesOfLb.put(lb,zs);
  }
}

void mappingInstancesToLb(){
  for(LoadBalancerImage lb : lImages.values()){
    Set<InstanceImage> inses = new HashSet<InstanceImage>();
    for(InstanceImage ins : iImages.values())
      if(lb.getInstanceIds().contains(ins.getId()))
        inses.add(ins);
    instancesOfLb.put(lb,inses);
  }
}


void setupHealthChecks(){

  //called only once 3000 miliseconds after thread dispatch.
  //initialize health check paramters.
  //and then, start hc worker thread.
  Runnable hcTask = 
    new Runnable(){
      public void run(){
        while(nowChanging)
          try{
            Thread.sleep(3000);
          }catch(Exception e){
          }
        try{
          Thread.sleep(3000);
        }catch(Exception e){
        }
        for(LoadBalancerImage lb : lImages.values()){
          Set<InstanceImage> inses = instancesOfLb.get(lb);
          for(InstanceImage ins : new ArrayList<InstanceImage>(inses))
            hcImages.add(new HealthCheckImage(lb, ins));
        }
        startHealthChecker();
      }
    };
  
  pool.submit(hcTask);
}

void startHealthChecker(){
  
  Runnable hcWorker = 
    new Runnable(){
      public void run(){
        while(true){
          for(LoadBalancerImage lb : lImages.values()){
            instanceStatesOfLbs.put(lb.getName(),lb.getInstanceHealths());
          }
          try{
            Thread.sleep(3000);
          }catch(Exception e){
          }
        }
      }
    };
  
  pool.submit(hcWorker);
}


