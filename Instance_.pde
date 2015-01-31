class InstanceImage{
  
  //entity in cloud
  Instance ins;
  
  //state  
  String latestState = "stopped";
  
  //location
  float xlocFrame;  //frame x location
  float ylocFrame;  //frame y location
  float frameSizeX;  //frame size x
  float frameSizeY;  //frame size y
  float xloc;       //sphere center x location
  float yloc;       //sphere center y location
  
  //radius of sphere
  float r = 50;

  //color of sphere
  float[] colorPending      = {255,170,0};
  float[] colorRunning      = {255,77,0};
  float[] colorStopping     = {173,95,50};
  float[] colorStopped      = {173,154,50};
  float[] colorShuttingDown = {168,168,168};
  float[] colorTerminated   = {240,240,240};  

  //color of instanceBackground
  float[] backColorRegistered = {250,235,215};
  
  //rotation
  float angleY          = 0;   //angle of y rotation.
  float rvPending      = 0.025;
  float rvRunning      = 0.05;
  float rvStopping     = 0.02;
  float rvStopped      = 0.00;
  float rvShuttingDown = 0.00;
  float rvTerminated   = 0.00;

  
  InstanceImage(Instance ins_){
    ins = ins_;
  }
  
  String getId(){
    return ins.getId();
  }
  String getIp(){
    String ipaddress = ins.getPublicIpAddress();
    return ipaddress == null ? "-" : ipaddress;
  }
  String getState(){
    return latestState;
  }
  void updateState(){
    latestState = ins.getStateName();
  }
  
  boolean pending(){
    return getState().equals("pending");
  }
  boolean running(){
    return getState().equals("running");
  }
  boolean stopping(){
    return getState().equals("stopping");
  }
  boolean stopped(){
    return getState().equals("stopped");
  }
  boolean shuttingDown(){
    return getState().equals("shutting-down");
  }
  boolean terminated(){
    return getState().equals("terminated");
  }
  
  String getZone(){
    return ins.getZoneName();
  }
  
  void setR( float r_){
    r = r_;
  }
  float getR(){
    return r;
  }
  
  void setFrame(float x, float y, float sx, float sy){
    setXlocFrame(x);
    setYlocFrame(y);
    setFrameSizeX(sx);
    setFrameSizeY(sy);
    setXloc(x + sx/2);
    setYloc(y + sy/2);
    setR(min(sx,sy)/5);
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

  void setXloc( float xloc_){
    xloc = xloc_;
  }
  float getXloc(){
    return xloc;
  }
  void setYloc( float yloc_){
    yloc = yloc_;
  }
  float getYloc(){
    return yloc;
  }
  
  void display(){
    
    asSphere();
    updateState();
  }

  void asSphere(){
    float[] c = getColor();

    stroke(255,100);
    strokeWeight(2);
    pushMatrix();
    translate(getXloc(), getYloc(), 0);
    rotateY(angleY);
    fill(c[0], c[1], c[2]);
    sphereDetail(12,12);
    sphere(r);
    popMatrix();
    angleY += getRv();
  } 
  
  void asRect(){
    float[] c = getColor();

    stroke(255,100);
    pushMatrix();
    translate(getXloc(), getYloc(), 0);
    rotateY(angleY);
    fill(c[0], c[1], c[2]);
    box(r);
    popMatrix();
    angleY += getRv();
  }  
  
  float[] getColor(){
    if (pending())
      return colorPending;
    else if(running())
      return colorRunning;
    else if(stopping())
      return colorStopping;
    else if(stopped())
      return colorStopped;
    else if(shuttingDown())
      return colorShuttingDown;
    else if(terminated())
      return colorTerminated;
    return colorStopped;
  }
   
  float getRv(){
    if (pending())
      return rvPending;
    else if(running())
      return rvRunning;
    else if(stopping())
      return rvStopping;
    else if(stopped())
      return rvStopped;
    else if(shuttingDown())
      return rvShuttingDown;
    else if(terminated())
      return rvTerminated;
    return rvStopped;
  }
  
  public boolean equals(Object o){
    if(o instanceof InstanceImage)
      return getId().equals(((InstanceImage)o).getId());
    return false;
  }
  
  void showDetail(){
    
    String message = 
      "Instance ID         : " + ins.getId() + "\n" +
      "Instance Type       : " + ins.getInstanceType() + "\n" +
      "Instance Lifecycle  : " + ins.getLifeCycle() + "\n" +
      "Image ID            : " + ins.getImageId() + "\n" +
      "Availability Zone   : " + ins.getZoneName() + "\n" +
      "VPC                 : " + ins.getVpcId() + "\n" +
      "Subnet              : " + ins.getSubnetId() + "\n" +
      "Public IP Address   : " + ins.getPublicIpAddress() + "\n" +
      "Instance State      : " + getState() + "\n" + 
      "Load balancer name  : " + "xxxxx" + "\n" +
      "Health check state  : " + "InService" + "\n";
    
    textSize(12);
    fill(0);
    textAlign(LEFT, CENTER);
    text(message,width/2, height/2, 30);
  }
  
  void displayForDetail(){
    setFrame(0,0,width/2,height);
    display();
  }  
}


