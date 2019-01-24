
class ArmyMoverStateRetreat implements ArmyMoverState{ 

  ArmyMover armyMover;
  
  ArmyMoverStateRetreat(ArmyMover armyMover){
    this.armyMover = armyMover;
  }
  
  ArmyMover firstSelectionArmy(float x, float y){
    return null;
  }

  void dragFromArmy(float x, float y){}

  void secondSelection(float x, float y){}

  void update(){}

  void display(boolean selected){}

  void updateWithZoomFactor(){
      armyMover.armySelectorSize*= GameConstants.zoomFactor;
    armyMover.soldierMover.updateArmyToZoom();
}

  void updateMapPosition(float dx, float dy){}

  void contactStarted(FContact c){}

}
