class SubnetImage{
  
  Subnet s;

  //state  
  String latestState = "available";
  
  //location
  float xlocFrame;   //frame x location
  float ylocFrame;   //frame y location
  float frameSizeX;  //frame size x
  float frameSizeY;  //frame size x
  float xloc;        //Subnet x location
  float yloc;        //Subnet y location
  float w;           //Subnet width
  float h;           //Subnet height

  //color
  float[] colorAvailable        = {111,255,240};

  
  SubnetImage(Subnet s_){
    s = s_;
  }  
 
  String getId(){
    return s.getId();
  }
  String getCidr(){
    return s.getCidrBlock();
  }
  String getState(){
    return s.getState();
  }

  void setFrame(float x, float y, float sx, float sy){
    setXlocFrame(x);
    setYlocFrame(y);
    setFrameSizeX(sx);
    setFrameSizeX(sy);
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

  void display(){
    float[] c = getColor();
    
    stroke(c[0],c[1],c[2]);
    fill(c[0],c[1],c[2]);
    rect(xloc, yloc, w, h, 7);
    
    //display instance images in own zone.
    //displayInstanceImages();    
  }

  float[] getColor(){
   return colorAvailable;
  }

}
