class TrailParticle {
  
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  color particleColor;
  float particleSize;
  
  float topspeed;
  float opacity;
  
  int lifespan;
  
  //construct the particles!!
  TrailParticle(PVector origin_) { 

    //standard location/velocity/acceleration
    location = origin_.get();
    velocity = new PVector();
    acceleration = new PVector();
    particleColor = color(random(200,255),random(0,30),random(10,30));
    particleSize = random(1,2);
    topspeed = 12;

    lifespan = (int) ((randomGaussian() * 50) + 10) ;

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

  //basic motion, with some damping to slow everything down
  void update() {
      velocity.add(acceleration);
      velocity.limit(topspeed);
      location.add(velocity);
      acceleration.mult(0);
  } 

  void display() {
    //they'll fade as they die!
      float opacity = map(lifespan,400,0,220,150);
      fill(particleColor,opacity);
      noStroke();
      rect(location.x, location.y, particleSize, particleSize);
  }
  
  boolean isDead() {
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }

}
