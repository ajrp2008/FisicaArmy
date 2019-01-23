class ArmyMover {

  ArmyMoverStateFollowPath   moverStateFollowPath = new ArmyMoverStateFollowPath(this);

  ArmyMoverState             moverState           = moverStateFollowPath;

  SoldiersMover              soldierMover;

  ArmyMover(SoldiersMover army) {
    this.soldierMover = army;
  }
  
  ArmyMover firstSelectionArmy(float x,float y){
     return moverState.firstSelectionArmy(x,y);
  }
  
  void update() {
    soldierMover.updateArmy();
    moverState.update();
  }

  void updateWithZoomFactor() {
    moverState.updateWithZoomFactor();
  }

  void updateMapPosition(float dx, float dy) {
    moverState.updateMapPosition(dx,dy);
  }

  void addWayPoint(float x, float y) {
    moverState.dragFromArmy(x, y);
  }

  void drawWayPoints(boolean selected) {
    moverState.display(selected);
  }
}
