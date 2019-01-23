class ArmyMoverStateWar implements ArmyMoverState {

  ArmyMover armyMover;

  ArmyMoverStateWar(ArmyMover armyMover) {
    this.armyMover = armyMover;
  }  

  ArmyMover firstSelectionArmy(float x, float y) {
    
    ArmyMover newSelectedArmy = null;
    PVector msp = armyMover.soldierMover.meanSoldierPosition();
    //FIRST SELECTION: SELECT THIS ARMY
    if (dist(msp.x, msp.y, x, y)<armyMover.armySelectorSize/2) {
      newSelectedArmy = armyMover;
    }
    return newSelectedArmy;
  }

  void dragFromArmy(float x, float y) {
  }

  void secondSelection(float x, float y) {
  }

  void update() {
    armyMover.soldierMover.updateArmy();
  }

  void display(boolean selected) {
      if (selected) stroke(armyMover.soldierMover.r, armyMover.soldierMover.g, armyMover.soldierMover.b, 300);
      else stroke(armyMover.soldierMover.r,armyMover.soldierMover.g, armyMover.soldierMover.b, 100);
      noFill();
  }


  void updateWithZoomFactor() {
    armyMover.armySelectorSize*= GameConstants.zoomFactor;
    armyMover.soldierMover.updateArmyToZoom();
  }

  void updateMapPosition(float dx, float dy) {
    armyMover.soldierMover.updateMapPosition(dx, dy);
  }

  void contactStarted(FContact c) {
    this.armyMover.soldierMover.contactStarted(c);
  }
}
