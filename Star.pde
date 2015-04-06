//This is the actual class that is rendered when the charge explodes

class Star {
  PVector origin;
  PVector location;
  PVector velocity;
  PVector acceleration;


  color particleColor;
  float particleSize;
  
  float opacity;
  
  int lifespan;
  int accelDelay;
  float friction;
  
  //construct the particles!!
  Star(PVector origin_, color color_, int lifespan_, float particleSize_) {

    location = origin_.get();
    velocity = new PVector();
    acceleration = new PVector();
    
    particleColor = color_;
    
    //default particle sizes
    particleSize = particleSize_;
    lifespan = lifespan_;

    friction = .95;
  }
  
  ////////////////////
  // Core functions //
  ////////////////////
  
  //standard run function
  void run() {
    update();
    display();

    lifespan--;
  }

  //run our physics updates
  void update() {
      velocity.add(acceleration);
      velocity.mult(friction);
      location.add(velocity);
      acceleration.mult(0);
  } 

  void display() {
      //they'll fade as they die!
      //map lifespan to opacity
      int opacity = (int)map(lifespan,300,0,255,180);
      fill(particleColor, opacity);
      noStroke();
      pushMatrix();
      translate(location.x, location.y, location.z);
      float xRot = radians(location.x * 5);
      float yRot = radians(location.y * 5);
      float zRot = radians(location.z * 5);
      rotate(xRot);
      rotate(yRot);
      rotate(zRot);
      box(particleSize);
      popMatrix();
  }
  



  ///////////////////////
  // Utility functions //
  ///////////////////////  

  //Does what it says on the box
  void changeSize(float particleSize_) {
    particleSize = particleSize_; 
  }
  
  //Allow the charge to change the size of the star
  void multSize(float mult_) {
    particleSize *= mult_; 
  }
  
  //pass along any forces to acceleration
  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.add(f); 
  }
  
  //pass along forces, but directly to velocity (more sudden)
  void detonate(PVector force) {
    PVector f = force.get();
    velocity.add(f); 
  }
  
  void changeFriction(float friction_) {
    friction = friction_;
  }

  //if the star is dead, tell the charge it's done.
  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }

  
}