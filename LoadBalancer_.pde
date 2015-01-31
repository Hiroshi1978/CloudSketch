import java.util.List;
import web.component.api.model.*;

class LoadBalancerImage{
  
  LoadBalancer lb;  
      
  //location
  float xlocFrame;  //frame x location
  float ylocFrame;  //frame y location
  float frameSizeX;  //frame size x
  float frameSizeY;  //frame size y
  float[] xlocs;       //sphere center x location
  float[] ylocs;       //sphere center y location
  String[] zNames;
  
  //radius
  float r = 50;

  //color
  float[] colorUnavailable      = {255,170,0};
  float[] colorAvailable      = {65,105,225};
  float[] colorDestroyed   = {240,240,240};  

  //rotation
  float angle          = 0;
  float rvUnavailable      = 0.00;
  float rvAvailable      = 0.02;
  float rvDestroyed   = 0.00;
  
  List<LoadBalancerLink> lnks;
  
  LoadBalancerImage(LoadBalancer lb_){
    lb = lb_; 
  }
  
  String getName(){
    return lb.getName();
  }

  boolean started(){
    return lb.isStarted();
  }
  boolean destroyed(){
    return lb.isDestroyed();
  }

  
  List<String> getInstanceIds(){
    List<Instance> binses = lb.getBackendInstances();
    List<String> ids = new ArrayList<String>();
    for(Instance ins : binses)
      ids.add(ins.getId());
    return ids;
  }
  
  Map<String,String> getInstanceHealths(){
    Map<String,String> instanceStates = new HashMap<String,String>();
    List<BackendState> states = lb.getInstanceStates();
    for(BackendState s : states)
      instanceStates.put(s.getInstanceId(),s.getState());
    return instanceStates;
  }
  
  List<String> getZoneNames(){
    List<Zone> zones = lb.getZones();
    List<String> names = new ArrayList<String>();
    for(Zone z: zones)
      names.add(z.getName());
    return names;
  }
  
  void setR( float r_){
    r = r_;
  }
  float getR(){
    return r;
  }
  
  void setFrame(float x, float y, float sx, float sy, List<ZoneImage> zones){
    setXlocFrame(x);
    setYlocFrame(y);
    setFrameSizeX(sx);
    setFrameSizeY(sy);
    
    xlocs  = new float[zones.size()];
    ylocs  = new float[zones.size()];
    zNames = new String[zones.size()];
    for(int i=0;i<zones.size();i++){
      ZoneImage z = zones.get(i);
      xlocs[i] = z.getXloc() + z.getW()/2;
      ylocs[i] = y + sy/2;
      zNames[i] = z.getName();
    }
    
    setR(min(sx/zones.size(),sy)/4);
    
    lnks = new ArrayList<LoadBalancerLink>();
    for(int i=0;i<xlocs.length-1;i++)
      lnks.add(new LoadBalancerLink(xlocs[i],ylocs[0],xlocs[i+1],ylocs[0]));
  }
  
  void setXlocFrame( float xlocFrame_){
    xlocFrame = xlocFrame_;
  }
  float getXlocFrame(){
    return xlocFrame;
  }
  void setYlocFrame( float ylocFrame_){
    ylocFrame = ylocFrame_;
  }
  float getYlocFrame(){
    return ylocFrame;
  }

  void setFrameSizeX( float frameSizeX_){
    frameSizeX = frameSizeX_;
  }
  float getFrameSizeX(){
    return frameSizeX;
  }
  void setFrameSizeY( float frameSizeY_){
    frameSizeY = frameSizeY_;
  }
  float getFrameSizeY(){
    return frameSizeY;
  }

  void setXlocs( float[] xlocs_){
    xlocs = xlocs_;
  }
  float[] getXlocs(){
    return xlocs;
  }
  void setYlocs( float[] ylocs_){
    ylocs = ylocs_;
  }
  float[] getYlocs(){
    return ylocs;
  }
  
  float getXlocZone(String zone){
    float xloc = 0;
    for(int i=0; i<zNames.length; i++)
      if(zNames[i].equals(zone)){
        xloc = xlocs[i];
        break;
      }
    return xloc;
  }

  float getYlocZone(String zone){
    float yloc = 0;
    for(int i=0; i<zNames.length; i++)
      if(zNames[i].equals(zone)){
        yloc = ylocs[i];
        break;
      }
    return yloc;
  }
  
  void display(float x, float y, float sx, float sy, List<ZoneImage> zones){
    setFrame( x,  y,  sx,  sy, zones);
    for(int i=0; i<xlocs.length;i++)
      asBox(xlocs[i],ylocs[i]);
    for(LoadBalancerLink lnk : lnks)
      lnk.updateAndDisplay();
  }
  
  void asBox(float x, float y){
    float[] c = getColor();

    stroke(255,100);
    pushMatrix();
    translate(x, y, 0);
    rotateY(angle);
    fill(c[0], c[1], c[2]);
    box(r);
    popMatrix();
    angle += getRv();
  }  
  
  
  float[] getColor(){
    return colorAvailable;
  }
   
  float getRv(){
    return rvAvailable;
  }
  
  public boolean equals(Object o){
    if(o instanceof LoadBalancerImage)
      return getName().equals(((LoadBalancerImage)o).getName());
    return false;
  }
  
  void showDetail(){
  }
}
