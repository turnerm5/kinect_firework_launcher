class Peony extends ShellSystem {
  
  Peony(PVector location) {
    super(location);
  }  
  
  //load our shell with new particles
  void initParticles() {
    
    detCharge = abs(randomGaussian() * 1) + 2.25 ;
    particleColor = color(20,30,random(220,255));
    numParticles = int(random(20,50));
    mult = .99;
    accelDelay = (int) random(20,35);
    topspeed = 50;
    
    
    for (int i = 0; i < numParticles; i++) {     
      //determine the size of each particle
      particleSize = random(6,8);
      accel = new PVector(.15 * randomGaussian(), .15 * randomGaussian());
      partLifespan = (int) ((randomGaussian() * 50) + 80);
      particleArray.add(new StandardParticle(location, particleColor, particleSize, detCharge, accel, mult, partLifespan, accelDelay, topspeed));
    }
  }
  
}
