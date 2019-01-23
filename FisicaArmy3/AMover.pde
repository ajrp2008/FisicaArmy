class ArmyMover {

    float armySelectorSize   = GameConstants.armySelectorSizeStart;

  
  ArmyMoverStateFollowPath   moverStateFollowPath = new ArmyMoverStateFollowPath(this);
  ArmyMoverStateWar          moverStateWar        = new ArmyMoverStateWar(this);

  ArmyMoverState             moverState           = moverStateFollowPath;

  SoldiersMover              soldierMover;

  ArmyMover(SoldiersMover army) {
    this.soldierMover = army;
    this.soldierMover.armyMover = this;
  }
  
  ArmyMover firstSelectionArmy(float x,float y){
     return moverState.firstSelectionArmy(x,y);
  }
  
  void secondSelection(float x, float y){
     moverState.secondSelection(x,y);
  }
  
  void update() {
    moverState.update();
  }

  void updateWithZoomFactor() {
    moverState.updateWithZoomFactor();
  }

  void updateMapPosition(float dx, float dy) {
    moverState.updateMapPosition(dx,dy);
  }

  void dragFromArmy(float x, float y) {
    moverState.dragFromArmy(x, y);
  }

  void drawWayPoints(boolean selected) {
    moverState.display(selected);
  }
  
  void contactStarted(FContact c){
    moverState.contactStarted(c);
  }

}
