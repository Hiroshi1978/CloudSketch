void mousePressed(){
  if(!showingInstanceDetail){
    for(InstanceImage i : iImages.values()){
      if(Math.abs(mouseX - i.getXloc()) <= i.getR())
        if(Math.abs(mouseY - i.getYloc()) <= i.getR()){
          showingInstanceDetail = true;
          filter(BLUR,5);
          forcusedInstance = i;
          i.showDetail();
          return;
        }
    }
    for(LoadBalancerImage l : lImages.values()){
      if(Math.abs(mouseX - (l.getXlocFrame() + l.getFrameSizeX()/2)) <= l.getFrameSizeX()/2)
        if(Math.abs(mouseY - (l.getYlocFrame() + l.getFrameSizeY()/2)) <= l.getFrameSizeY()/2){
          showingLbDetail = true;
          filter(BLUR,5);
          forcusedLb = l;
          l.showDetail();
          return;
        }
    }
  }else{
    showingInstanceDetail = false;
    showingLbDetail = false;
    forcusedInstance = null;
  }   
}

