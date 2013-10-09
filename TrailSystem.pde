import java.util.Iterator;

class TrailSystem{
 
  float particleSize, x, y;
  color particleColor;
  boolean isDead;
  float topspeed;
  int timer;
  float yVelocity;
  
  ArrayList<TrailParticle> particleArray;
  ArrayList<ShellSystem> charges;
  
  PVector location;
  PVector velocity;
  PVector acceleration;
    
  TrailSystem(PVector location_) {
    location = location_.get();
    yVelocity = random(-18,-14);
    velocity = new PVector(random(-2,2),yVelocity);
    acceleration = new PVector(0,8);
    
    particleArray = new ArrayList<TrailParticle>();
    charges = new ArrayList<ShellSystem>();
    
    topspeed = 12;
    timer = int( -1 * (yVelocity - 50));    
  }
  
  void addTrailParticle() {
    if (timer > 0) {
      particleSize = random(1,2);
      //determine fly color (Yellowish?)
      particleColor = color(random(200,255),random(0,30),random(10,30));   
      //fill our array with instances of the superpixels
      particleArray.add(new TrailParticle(location, particleColor, particleSize));
    }
  }
  
  void update() {
      velocity.add(acceleration);
      velocity.mult(.999);
      velocity.limit(topspeed);
      location.add(velocity);
      acceleration.mult(0);
      timer--;
  } 
  
  void run() {
    
    update();
    addTrailParticle();
    //checkEdges();
    explode();
    Iterator<TrailParticle> it = particleArray.iterator();
    
    while (it.hasNext()) {
      TrailParticle f = it.next();    
      f.run();
      if (f.isDead()) {
        it.remove(); 
      }
    }

    Iterator<ShellSystem> ss = charges.iterator();
    
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
}
