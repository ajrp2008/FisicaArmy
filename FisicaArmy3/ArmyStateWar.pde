class ArmyStateWar implements ArmyState {

  Army      army;
  FContact  firstContact;
  PVector   positionContact = new PVector();

  int       frameCount;
  int       colisionFrame  = 50;
  

  ArmyStateWar(Army army) {
    this.army = army;
  }

  void commandArmyPosition(float x, float y) {
  }

  void commandArmyHeading(float x, float y) {
  }

  void updateArmySoldiers() {
    frameCount++;
    if ((frameCount%(20*(int)random(1,3))==0 || frameCount%50==0) && frameCount>colisionFrame) { //After 50 frames - move towa
      for (Soldier s : army.soldiers) {
        float dx = -s.getX() + positionContact.x; //s.army.absolutPosition.x;
        float dy = -s.getY() + positionContact.y;//s.army.absolutPosition.y;
        PVector p = new PVector(dx,dy);
        //p.normalize();
        p.mult(0.25*random(1,3));
        s.setVelocity(p.x, p.y);
        s.setFilterBits(11);
      }
    }
  }

  void updateState() {
  }
  
    
  void updateArmyToZoom(){
  }

  boolean isMarching() {
    return true;
  }

  void contactStarted(FContact c) {
    if(this.firstContact==null){
      this.firstContact = c;
      this.positionContact = new PVector(c.getX(),c.getY());
    }
    
    if(frameCount > colisionFrame){
      Soldier s1 = (Soldier)c.getBody1();
      Soldier s2 = (Soldier)c.getBody2();
      s1.attack(s2);
      s2.attack(s1);
      
    }
  }
}
