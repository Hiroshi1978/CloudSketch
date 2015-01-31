//shared by all hc instances.
static Map<String,Map<String,String>> instanceStatesOfLbs = new ConcurrentHashMap<String,Map<String,String>>();

class HealthCheckImage{
  
  LoadBalancerImage lb;
  InstanceImage ins;
  PVector o;
  PVector d;
  PVector v; 
  PVector p;
  boolean ready = false;
  float[] colorOutOfService = {128,128,128};
  float[] colorInService    = {230,230,250};
  float[] colorChecking     = {255,255,0};
  boolean inService = false;

  
   HealthCheckImage(LoadBalancerImage lb_, InstanceImage ins_){
      
     lb = lb_;
     ins = ins_;
     
     String zName = ins.getZone();
     
     float xstart = lb.getXlocZone(zName);
     float ystart = lb.getYlocZone(zName);
     float xend = ins.getXloc();
     float yend = ins.getYloc()-ins.getR()*2;
     
     o = new PVector(xstart,ystart);
     d = new PVector(xend,yend);
     float distance = d.dist(o);
     v = d.get();
     v.sub(o);
     v.normalize();
     v.mult(distance * 0.008);
     p = o.get();
     
     ready = true;
   }
   
   boolean ready(){
     return ready;
   }
   
   boolean update(){
     boolean reached = reachedToGoal();
     if (reached){
       updateHealthCheckState();
       p = o.get();
     }else
       p.add(v);
     return reached;
   }

   void display(boolean reached){
     
     float[] cWhenNotReached = inService ? colorInService : colorOutOfService;
     float[] c               
     = reached ? colorChecking : cWhenNotReached;
     
     stroke(c[0],c[1],c[2]);
     strokeWeight(0.8);
     line(o.x,o.y,d.x,d.y);
     markAsRegistered(c[0],c[1],c[2]);
     
     stroke(255,255,255);
     strokeWeight(1);
     fill(colorChecking[0],colorChecking[1],colorChecking[2]);
     ellipse(p.x,p.y,5,5);
   }
   void updateAndDisplay(){
     display(update());
   }
   
   //return true if arrow reached to the target instance.
   boolean reachedToGoal(){
     return p.dist(d) < v.mag();
   }
   
   void markAsRegistered(float cr, float cg, float cb){
     noStroke();
     strokeWeight(1);
     fill(cr,cg,cb);
     rect( ins.getXloc()-ins.getR()*2,
           ins.getYloc()-ins.getR()*2,
           ins.getR()*4,
           ins.getR()*4                 );
   }
  
  void updateHealthCheckState(){
    String lbName = lb.getName();
    Map<String,String> iStates = instanceStatesOfLbs.get(lbName);
    if(iStates == null)
      return;
    String state = iStates.get(ins.getId());
    inService = state == null ? false : state.equals("InService");
  }
}


