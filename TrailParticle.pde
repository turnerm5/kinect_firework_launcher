class TrailParticle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  color particleColor;
  float particleSize;
  
  float topspeed;
  float m;
  
  int lifespan;
  
  
  //construct the particles!!
  TrailParticle(PVector origin_,  color particleColor_, float particleSize_) {

    //standard location/velocity/acceleration
    location = origin_.get();
    velocity = new PVector(random(-1,1),random(-1,1));
    acceleration = new PVector(0,.5);
    
    //how should we fill the square? how big are they
    particleColor = particleColor_;
    particleSize = particleSize_;
    topspeed = 12;

    lifespan = (int) ((randomGaussian() * 50) + 10) ;

  }
  
  void run() {
   update();
   
   display();
   
   lifespan--;
  }
  
  void applyForce(float force) {
    PVector f = new PVector(0, force);
    acceleration.add(f);
  }

  //basic motion, with some damping to slow everything down
  void update() {
      velocity.add(acceleration);
      velocity.mult(.98);
      velocity.limit(topspeed);
      location.add(velocity);
      acceleration.mult(0);
  } 

  //draw the firefly
  void display() {
    //they'll explode as they die!
      float m = map(lifespan,400,0,220,150);
      //buffer.fill(particleColor,m);
      //buffer.noStroke();
      //buffer.rect(location.x, location.y, particleSize, particleSize);
      
      fill(particleColor,m);
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
