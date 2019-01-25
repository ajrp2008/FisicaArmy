class SoldiersMoverStateRetreat implements SoldiersMoveState {

      SoldiersMover    army;
  PVector retreatToLocation = new PVector();

  SoldiersMoverStateRetreat(SoldiersMover army){
    this.army = army;
  }

    void commandArmyPosition(float x, float y){}

    void commandArmyHeading(float x, float y){}
    
    void updateArmySoldiers(){}
    
    void updateState(){
        army.isMarching = false;
    for(Soldier s: army.soldiers){
      s.updatePosition();
      if(s.isMarching()){army.isMarching=true;}
    }

    }
    
    boolean isMarching(){return false;}
    
    void contactStarted(FContact c){}
    
    void retreatTo(float x, float y){}
    
    void updateArmyToZoom(){
     army.absolutPosition.mult(GameConstants.zoomFactor);
        for(Soldier s: army.soldiers){
            s.updateSoldierSizeToZoom();
            s.relPosition.mult(GameConstants.zoomFactor);
           s.setPosition(s.getX()*GameConstants.zoomFactor,s.getY()*GameConstants.zoomFactor);
          }
  }

    

  
}
