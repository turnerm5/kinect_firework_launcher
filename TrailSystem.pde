import java.util.Iterator;

class TrailSystem{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  boolean launched;
  boolean isDead;
  
  float topspeed;
  int timer;
  
  ArrayList<TrailParticle> trailArray;
  ArrayList<ShellSystem> chargeArray;
    
  TrailSystem(PVector location_, int timer_) {
    launched = false;
    location = location_.get();
    
    //launch the fireworks. would this be better accomplished through an applyForce function?
    velocity = new PVector();
    acceleration = new PVector();
    
    
    trailArray = new ArrayList<TrailParticle>();
    chargeArray = new ArrayList<ShellSystem>();
    
    topspeed = 12;
    timer = timer_;    
  }
  
  void addTrailParticle() {
    if (timer > 0) {
      trailArray.add(new TrailParticle(location));
    }
  }
  
  void launch(PVector force) {
    PVector f = force.get();
    velocity.add(f);
    launched = true;
  }
  
  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.add(f);
    
    for (TrailParticle p: trailArray) {
      p.applyForce(force);
    }
  }
  
  void update() {
      velocity.add(acceleration);
      location.add(velocity);
      velocity.limit(topspeed);
      acceleration.mult(0);
      addTrailParticle();
      timer--;
  } 
    
  void manageTrail() {
    Iterator<TrailParticle> it = trailArray.iterator();
    
    while (it.hasNext()) {
      TrailParticle f = it.next();    
      f.run();
      if (f.isDead()) {
        it.remove(); 
      }
    }
    
  }
  
  void manageCharges() {
    Iterator<ShellSystem> ss = chargeArray.iterator();
    
    while (ss.hasNext()) {
      ShellSystem s = ss.next();    
      s.run();
      if (s.isDead()) {
        ss.remove(); 
      }
    }
  }
   
  void explode() {
   if (timer == 0) {
     ellipse(location.x,location.y,12,12);
     
     //add a new ShellSystem at the location of the emitter
     float zz = random(0,1);
     if (zz < .25) {
       charges.add(new Peony(location));
     } else if (zz < .5) {
       charges.add(new Wacky(location));
     } else {
       charges.add(new ShellSystem(location));
       println("SS added");
     }
   }
  }
  
  void checkEdges() {
    //make the fireworks bounce off the edges. it's offset a bit so you can chase them off-screen  
    if (location.x < 0) {
      location.x = 0;
      velocity.x *= -.97;
    } 
    else if (location.x > width) {
      location.x = width;
      velocity.x *= -.97;
    }

    if (location.y < 0) {
      location.y = 0;
      velocity.y *= -.97;
    } 
    else if (location.y > height - 2) {
      location.y = height;
      velocity.y *= -.97;
    }
  }
  
  boolean isDead() {
    if (timer < -200) {
      return true;
    } else {
      return false;
    }
  }
    
  void run() {
    update();
    manageTrail();
    explode();
    manageCharges();
  }
}
