class SoldiersMoverStateWar implements SoldiersMoveState {

  SoldiersMover      army;
  FContact  firstContact;
  PVector   positionContact = new PVector();

  int       frameCount;
  int       colisionFrame  = 50;
  

  SoldiersMoverStateWar(SoldiersMover army) {
    this.army = army;
  }

  void commandArmyPosition(float x, float y) {
  }

  void commandArmyHeading(float x, float y) {
  }

  void updateArmySoldiers() {
    frameCount++;
    //if ((frameCount%(20*(int)random(1,3))==0 || frameCount%50==0) && frameCount>colisionFrame) { //After 50 frames - move towa
      if(frameCount == 1 || (frameCount%50==0 && frameCount>colisionFrame)){
      for (Soldier s : army.soldiers) {
        float dx = -s.getX() + positionContact.x; //s.army.absolutPosition.x;
        float dy = -s.getY() + positionContact.y;//s.army.absolutPosition.y;
        PVector p = new PVector(dx,dy);
        p.mult(0.25*random(1,3));
        s.setVelocity(p.x, p.y);
      }
    }
    
    
    
  }

  void updateState() {
  }
  
    
  void updateArmyToZoom(){
    positionContact.mult(GameConstants.zoomFactor);
     army.absolutPosition.mult(GameConstants.zoomFactor);
        for(Soldier s: army.soldiers){
            s.updateSoldierSizeToZoom();
            s.relPosition.mult(GameConstants.zoomFactor);
            s.setPosition(s.getX()*GameConstants.zoomFactor,s.getY()*GameConstants.zoomFactor);
          }
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
  
  void retreatTo(float x, float y){
    this.firstContact = null;
    ((SoldiersMoverStateRetreat)this.army.armyRetreat).retreatToLocation.set(x,y);
    this.army.absolutPosition.set(x,y);
    this.army.armyState = this.army.armyRetreat;
  }
  
}
