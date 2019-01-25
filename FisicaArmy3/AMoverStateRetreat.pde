
class ArmyMoverStateRetreat implements ArmyMoverState{ 

    PVector retreatToLocation = new PVector();
  
  ArmyMover armyMover;
  
  ArmyMoverStateRetreat(ArmyMover armyMover){
    this.armyMover = armyMover;
  }
  
  ArmyMover firstSelectionArmy(float x, float y){
    return null;
  }

  void dragFromArmy(float x, float y){}

  void secondSelection(float x, float y){}

  void update(){
        armyMover.soldierMover.updateArmy();
              PVector msp = armyMover.soldierMover.meanSoldierPosition();

        if(dist(retreatToLocation.x,retreatToLocation.y, msp.x,msp.y)<armyMover.armySelectorSize/2){
          
          this.armyMover.soldierMover.armyState = this.armyMover.soldierMover.armyMarch;
          
          ((ArmyMoverStateFollowPath)this.armyMover.moverStateFollowPath).wayPoints.clear();
          ((ArmyMoverStateFollowPath)this.armyMover.moverStateFollowPath).approveRoute = false;
          ((ArmyMoverStateFollowPath)this.armyMover.moverStateFollowPath).nextPoint = null;
          this.armyMover.moverState = this.armyMover.moverStateFollowPath;

        }        
  }

  void display(boolean selected){
        if(retreatToLocation != null) ellipse(retreatToLocation.x,retreatToLocation.y,30,30);
  }

  void updateWithZoomFactor(){
      armyMover.armySelectorSize*= GameConstants.zoomFactor;
    armyMover.soldierMover.updateArmyToZoom();
    retreatToLocation.mult(GameConstants.zoomFactor);
}

  void updateMapPosition(float dx, float dy){
        armyMover.soldierMover.updateMapPosition(dx, dy);
        retreatToLocation.add(dx,dy);
  }

  void contactStarted(FContact c){}

}
