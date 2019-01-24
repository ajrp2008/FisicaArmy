class SoldiersMoverStateRetreat implements SoldiersMoveState {

    
    void commandArmyPosition(float x, float y){}

    void commandArmyHeading(float x, float y){}
    
    void updateArmySoldiers(){}
    
    void updateState(){}
    
    boolean isMarching(){return false;}
    
    void contactStarted(FContact c){}
    
    void retreatTo(float x, float y){}
    
    void updateArmyToZoom(){
  /*   army.absolutPosition.mult(GameConstants.zoomFactor);
        for(Soldier s: army.soldiers){
            s.updateSoldierSizeToZoom();
            //s.updateSoldierPositionToZoom();
            s.setPosition(s.getX()*GameConstants.zoomFactor,s.getY()*GameConstants.zoomFactor);
          }*/
  }

    

  
}
