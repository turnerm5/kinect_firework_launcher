class StandardParticle {
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
  StandardParticle(PVector origin_, color color_) {

    location = origin_.get();
    velocity = new PVector();
    acceleration = new PVector();
    
    particleColor = color_;
    particleSize = random(.5,2);
    lifespan = (int) ((randomGaussian() * 10) + 40);
  }
  
  void run() {
    update();
    display();
    lifespan--;
  }
  
  void applyForce(PVector force) {
    PVector f = force.get();
    acceleration.add(f); 
  }
  
  void detonate(PVector force) {
    PVector f = force.get();
    velocity.add(f); 
  }
  
  void update() {
      velocity.add(acceleration);
      velocity.mult(.92);
      location.add(velocity);
      acceleration.mult(0);
  } 

  void display() {
      //they'll fade as they die!
      int opacity = (int)map(lifespan,400,0,255,180);
      fill(particleColor, opacity);
      noStroke();
      rect(location.x, location.y, particleSize, particleSize);
  }
  
  void checkEdges() {
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
