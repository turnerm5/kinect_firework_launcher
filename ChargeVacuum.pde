class ChargeVacuum extends ChargeBasic {
  
  ChargeVacuum(PVector location) {
    super(location);
    
    //smaller number of particles
    numParticles = (int) random(50,100);

    //larger stars
    lowerSize = 5;
    upperSize = 10;

    //a medium size explosion
    detChargeX = 20;
    detChargeY = 20;
    detChargeZ = 20;

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

    void run(){
        super.run();
        vacuum(location);
    }   
}