class ChargeVacuum extends ChargeBasic {
  
  int secondaryTimer;
  boolean timerStarted = false;

  ChargeVacuum(PVector location) {
    super(location);
    
    //smaller number of particles
    numParticles = (int) random(100,200);

    //larger stars
    lowerSize = 3;
    upperSize = 5;

    //a medium size explosion
    detChargeX = 20;
    detChargeY = 20;
    detChargeZ = 20;

    secondaryTimer = 50;

    lifespanBase = 60;

    //gravity is normal
    forceMultiplier = 1;


  }

    void vacuum(PVector startLocation) {
        Iterator<Star> it = starArray.iterator();
        while (it.hasNext()) {
            Star s = it.next();    
            PVector v = startLocation.get();
            v.sub(s.location);
            v.mult(.007);
            s.applyForce(v);
            }
    }

    void detonate(){
        super.detonate();
        timerStarted = true;

    }

    void run(){
        super.run();
        if (timerStarted) {
            secondaryTimer--;
        }
        if (secondaryTimer < 0) {
            vacuum(location);
        }
    }   
}