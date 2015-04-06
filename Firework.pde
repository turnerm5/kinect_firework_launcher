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
  ArrayList<ChargeBasic> chargeArray;
    
  Firework(PVector location_, int timer_) {
    launched = false;
    location = location_.get();
    
    velocity = new PVector();
    acceleration = new PVector();
    
    trailArray = new ArrayList<TrailParticle>();
    
    //probably overkill to use an arraylist for this, but we get such nice functions!
    chargeArray = new ArrayList<ChargeBasic>();
    
    topspeed = 12;
    timer = timer_;    
  }
  
  void run() {
    //apply our forces
    update();
    //make sure our trail looks nice
    manageTrail();
    //if the timer is up, explode!
    explode();
    //manage all of the charges (there should only be 1 per firework, right?)
    manageCharges();
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
  
  //keep adding particles until the firework explodes
  void addTrailParticle() {
    
    if (timer > 0) {
      trailArray.add(new TrailParticle(location));
    }
  }
  
  //keep the trail running nicely
  void manageTrail() {
    Iterator<TrailParticle> it = trailArray.iterator();
    
    //our general iterator functions
    while (it.hasNext()) {
      TrailParticle tp = it.next();    
      tp.run();

      tp.applyForce(gravity);

      if (tp.isDead()) {
        it.remove(); 
      }
    }
  }

  //our explosion function!
  void explode() {
    if (timer == 0) {
      pushMatrix();
      translate(location.x, location.y, location.z);
      pointLight(255,255,255,0,0,0);
      fill(255);
      sphere(15);
      popMatrix();

      //randomly use a basic charge, or wacky charge
      float test = random(0,1);
      if (test < .3) {
        chargeArray.add(new ChargeBasic(location));
      } else if (test < .66) {
        chargeArray.add(new ChargeWacky(location));
      } else {
        chargeArray.add(new ChargeWillow(location));
      }
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
  
  void manageCharges() {
    Iterator<ChargeBasic> ca = chargeArray.iterator();
    
    while (ca.hasNext()) {
      ChargeBasic c = ca.next();    
      
      //run our charge's run function
      c.run();
      
      //keep passing gravity to the lower classes
      c.applyForce(gravity);

      //if we haven't detonated yet, detonate!
      if (!c.detonated) {
        c.detonate();
      }
      
      //remove the charge from the array if it's done
      if (c.isDead()) {
        ca.remove();
      }
    }
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