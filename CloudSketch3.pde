void setup(){
  //size(int(displayWidth * 0.6), int(displayHeight * 0.6), P3D);
  size(1000,600,P3D);
  setupThreadPool();
  setupResouces();
  setupImages();

  startInstanceMemberChecker();
}

void draw(){
  
  if(nowChanging){
    showingInstanceDetail = false;
    showingLbDetail = false;
    background(255);
    drawNowChanging();
  }else if(showingInstanceDetail){
    forcusedInstance.displayForDetail();
  }else if(showingLbDetail){
  }else{
    background(200);
    drawImages();
    drawTexts();
  }
}

