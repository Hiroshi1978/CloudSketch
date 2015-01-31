class LoadBalancerLink{
  
  PVector o;
  PVector d;
  PVector v; 
  PVector p;
  boolean ready = false;
  
   LoadBalancerLink(
       float xstart,float ystart,
       float xend,  float yend
     ){
       initialize(xstart,ystart,xend,yend);
   }
   
   void initialize(
       float xstart,float ystart,
       float xend,  float yend
     ){
     o = new PVector(xstart,ystart);
     d = new PVector(xend,yend);
     v = d.get();
     v.sub(o);
     v.normalize();
     v.mult(3);
     p = o.get();
     ready = true;
   }
   
   boolean ready(){
     return ready;
   }
   
   void update(){
     if (reachedToGoal())
       p = o.get();
     else
       p.add(v);
   }

   void display(){
    
     stroke(65,65,224);
     strokeWeight(0.8);
     line(o.x,o.y,d.x,d.y);
    
     stroke(255,255,255);
     strokeWeight(1);
     fill(255,255,0);
     ellipse(p.x,p.y,5,5);
   }
   void updateAndDisplay(){
     update();
     display();
   }
   
   //return true if arrow reached to the target instance.
   boolean reachedToGoal(){
     return p.dist(d) < v.mag();
   }
}


