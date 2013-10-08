class StandardParticle {
  PVector origin;
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector target;
  color particleColor;
  float particleSize;
  float topspeed;
  float m;
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
    
    //a nice organic lifespan. doesn't look too rigid
    lifespan = lifespan_ ;

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
    
    accelDelay--;  
    
    if (accelDelay < 0) {
      velocity.add(acceleration);
    }
      //slows them down as they travel.
      velocity.mult(friction);
      
      velocity.limit(topspeed);
      location.add(velocity);
      //acceleration.mult(0);
  } 

  //draw the firefly
  void display() {
    //they'll explode as they die!
      int m = (int)map(lifespan,400,0,255,180);
      //buffer.fill(particleColor,m);
      //buffer.noStroke();
      //buffer.rect(location.x, location.y, particleSize, particleSize);
      
      fill(particleColor,m);
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
