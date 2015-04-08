import java.util.Iterator;

// A Firework is the highest level class
// It controls a Charge and a Trail


class Firework{
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  boolean launched;
  boolean isDead;
  
  float topspeed;
  int timer;
  
  ArrayList<TrailParticle> trailArray;
  
  //each firework only has one charge
  ChargeBasic charge;
    
  Firework(PVector location_, int timer_) {
    launched = false;
    location = location_.get();
    
    velocity = new PVector();
    acceleration = new PVector();
    
    trailArray = new ArrayList<TrailParticle>();
    

    //randomly use a basic charge, or wacky charge
    float test = random(0,1);
    
    int charges = 6;
    float fraction = 1.0 / charges;

    if (test < 1.0 * fraction) {
      charge = new ChargeBasic(location);
      println("Basic charge");
    } else if (test < 2.0 * fraction) {
      charge = new ChargeWacky(location);
      println("Wacky charge");
    } else if (test < 3.0 * fraction) {
      charge = new ChargeWillow(location);
      println("Willow charge");
    } else if (test < 4.0 * fraction) {
      charge = new ChargeVacuum(location);
      println("Vacuum charge");
    } else if (test < 5.0 * fraction) {
      charge = new ChargeDouble(location, false);
      println("Double charge");
    } else {
      charge = new ChargeCool(location);
      println("Cool Charge");
    }
    
    topspeed = 12;
    timer = timer_;

  }
  
  ////////////////////
  // Core functions //
  ////////////////////

  void run() {
    //apply our forces
    update();
    //make sure our trail looks nice
    manageTrail();
    //manage all of the charges
    manageCharge();
  
    //if the timer is up, explode!
    if (timer == 0) {
      explode();
    }

  }
  
  //function to apply our physical functions
  void update() {
      velocity.add(acceleration);
      location.add(velocity);
      velocity.limit(topspeed);
      acceleration.mult(0);
      addTrailParticle();
      timer--;
  } 
  
  //keep the trail running nicely
  void manageTrail() {
    Iterator<TrailParticle> it = trailArray.iterator();
    while (it.hasNext()) {
      TrailParticle tp = it.next();    
      tp.run();
      tp.applyForce(gravity);
      if (tp.isDead()) {
        it.remove(); 
      }
    }
  }

  void manageCharge() {
    charge.run();
    charge.applyForce(gravity);
    charge.changeLocation(location);
  }

  //our explosion function!
  void explode() {
    pushMatrix();
    translate(location.x, location.y, location.z);
    pointLight(255,255,255,0,0,0);
    fill(255);
    sphere(15);
    popMatrix();
    charge.detonate();
  }


  ///////////////////////
  // Utility functions //
  ///////////////////////  

  //keep adding particles
  void addTrailParticle() { 
    if (timer > 0) {
      trailArray.add(new TrailParticle(location));
    }
  }
  
  //apply the launch force
  void launch(PVector force) {
    PVector f = force.get();
    velocity.add(f);
    launched = true;
  }
  
  //general function to apply 
  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.add(f);
  }
  
  boolean isDead() {
    //if this is set to 0, it disappears as soon as it explodes.
    //you need a buffer to make sure it sticks around until the particles have done their thing
    if (timer < -300) {
      return true;
    } else {
      return false;
    }
  }
}