class ArmySelector {
  float                     armySelectorSize   = GameConstants.armySelectorSizeStart;

  ArmyMover             selectedArmy      = null;
  ArrayList<ArmyMover>  armyList          = new ArrayList<ArmyMover>();

  void addArmy(ArmyMover a) {
    armyList.add(a);
  }

  boolean selectArmy(float x, float y) {
    ArmyMover newSelectedArmy = null;

    for (ArmyMover a : armyList) {
      ArmyMover selected =a.firstSelectionArmy(x,y);  
      if(selected!=null)  newSelectedArmy = selected;
    }
    
    if(selectedArmy != null) selectedArmy.secondSelection(x,y);

    
    selectedArmy = newSelectedArmy;
  

    return selectedArmy != null;
  }

  boolean dragFromArmy(float x, float y) {
    if (selectedArmy!=null) {
      selectedArmy.dragFromArmy(x, y);
    }
    return    selectedArmy != null;
  }

  void updateWithZoomFactor() {
    armySelectorSize *= GameConstants.zoomFactor;
    for (ArmyMover ap : this.armyList) {
      ap.updateWithZoomFactor();
    }
  }

  void updateMapPosition(float dx, float dy) {     
    for (ArmyMover ap : armySelector.armyList) {
      ap.updateMapPosition(dx,dy);
    }
  }

  void update() {
    for (ArmyMover a : armyList) {
      a.update();
    }
  }

  void drawSelector() {
    for (ArmyMover a : armyList) {
      a.drawWayPoints(a == selectedArmy);

      //CENTER OF ARMY///////////////////////////
      PVector msp = a.soldierMover.meanSoldierPosition();
      noStroke();
      fill(30,0,0,100);
      if(a == selectedArmy) fill(255,255,0,100);
      ellipse(msp.x, msp.y, armySelectorSize, armySelectorSize);
      stroke(255,0,0);
      if(a == selectedArmy)textSize(30); else textSize(15); 
      text(a.soldierMover.name,msp.x+armySelectorSize/2, msp.y);
      text( ""+a.soldierMover.absolutPosition,msp.x+armySelectorSize/2, msp.y+30);
      text( "Start. "+ a.soldierMover.soldiers.size() + " Alive:"+a.soldierMover.armySizeAlive(),msp.x+armySelectorSize/2, msp.y+60);
      ///////////////////////////////////////////

    }

  }
}
