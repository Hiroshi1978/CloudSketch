class VPCImage{
  
  VPC v;

  //state  
  String latestState = "available";
  
  //location
  float xlocFrame;   //frame x location
  float ylocFrame;   //frame y location
  float frameSizeX;  //frame size x
  float frameSizeY;  //frame size x
  float xloc;        //vpc x location
  float yloc;        //vpc y location
  float w;           //vpc width
  float h;           //vpc height

  //color
  float[] colorAvailable        = {240,255,240};

  
  VPCImage(VPC v_){
    v = v_;
  }  
 
  String getId(){
    return v.getId();
  }
  String getCidr(){
    return v.getCidrBlock();
  }
  String getState(){
    return v.getState();
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
