class ZoneImage{

  //entity in cloud
  Zone z;
  
  //state  
  String latestState = "available";
  
  //location
  float xlocFrame;   //frame x location
  float ylocFrame;   //frame y location
  float frameSizeX;  //frame size x
  float frameSizeY;  //frame size x
  float xloc;        //zone x location
  float yloc;        //zone y location
  float w;           //zone width
  float h;           //zone height
  
  //color
  float[] colorAvailable        = {240,255,240};
  
  //instances in this zone.
  List<InstanceImage> insImages = new ArrayList<InstanceImage>();
  
  ZoneImage(Zone z_){
    z = z_;
  }
  
  String getName(){
    return z.getName();
  }
  
  void setInstances(List<InstanceImage> insImages_){
    insImages.addAll(insImages_);
  }
  List<InstanceImage> getInstances(){
    return insImages;
  }
  void setInstance(InstanceImage insImage){
    insImages.add(insImage);
  }
  
  void clearInstances(){
    insImages.clear();
  }
  
  void setFrame(float x, float y, float sx, float sy){
    setXlocFrame(x);
    setYlocFrame(y);
    setFrameSizeX(sx);
    setFrameSizeY(sy);
    setXloc(x + sx * 0.05);
    setYloc(y + sy * 0.05);
    setW(sx*0.9);
    setH(sy*0.9);
  }

  void setFrameSizeX( float w){
    frameSizeX = w;
  }
  float getFrameSizeX(){
    return frameSizeX;
  }
  void setFrameSizeY( float h){
    frameSizeY = h;
  }
  float getFrameSizeY(){
    return frameSizeY;
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
  void setW( float w_){
    w = w_;
  }
  float getW(){
    return w;
  }
  void setH( float h_){
    h = h_;
  }
  float getH(){
    return h;
  }
  
  void display(float x, float y, float sx, float sy){
    
    setFrame(x,y,sx,sy);
    float[] c = getColor();
    stroke(c[0],c[1],c[2]);
    fill(c[0],c[1],c[2]);
    rect(xloc, yloc, w, h, 7);
  }
  
  float[] getColor(){
   return colorAvailable;
  }
  
}
