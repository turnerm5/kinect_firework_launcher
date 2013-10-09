class StandardParticle {
  PVector origin;
  PVector location;
  PVector velocity;
  PVector acceleration;

  color particleColor;
  float particleSize;
  
  float topspeed;
  float opacity;
  
  int lifespan;
  int accelDelay;
  float friction;
  
  //construct the particles!!
  StandardParticle(PVector origin_,  color particleColor_, float particleSize_, float detCharge_,  PVector acceleration_, float mult_, int lifespan_, int accelDelay_, float topspeed_) {

    //standard location/velocity/acceleration
    location = origin_.get();
    velocity = new PVector(random( -1 *(randomGaussian()*detCharge_), randomGaussian()*detCharge_) , random(-1 * (randomGaussian()*detCharge_), randomGaussian()*detCharge_));
    acceleration = acceleration_;
    
    //how should we fill the square? how big are they
    particleColor = particleColor_;
    particleSize = particleSize_;
    topspeed = topspeed_;
    
    accelDelay = accelDelay_;
    
    friction = mult_;

    lifespan = lifespan_ ;

  }
  
  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.add(f); 
  }
  
  void run() {
   update();
   //checkEdges();
   display();
   lifespan--;
  }
  
  void seek(PVector target_) {
    PVector dir = PVector.sub(target_, location);
    dir.normalize();
    dir.mult(0.1);
    acceleration = dir;
  }
  
  //basic motion, with some damping to slow everything down
  void update() {
    
    //a timer to prevent them from accelerating right away. I think this should be done a little differently.
    accelDelay--;
    
    if (accelDelay < 0) {
      velocity.add(acceleration);
    }
      //slows them down as they travel.
      velocity.mult(friction);
      velocity.limit(topspeed);
      location.add(velocity);
      acceleration.mult(0);
  } 

  //draw the firefly
  void display() {
      //they'll fade as they die!
      int opacity = (int)map(lifespan,400,0,255,180);
      fill(particleColor, opacity);
      noStroke();
      rect(location.x, location.y, particleSize, particleSize);
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
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }

  
}
