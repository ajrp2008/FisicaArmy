class ArmySelector {
  float                     armySelectorSize   = GameConstants.armySelectorSizeStart;

  ArmyPathFinder             selectedArmy      = null;
  ArrayList<ArmyPathFinder>  armyList          = new ArrayList<ArmyPathFinder>();

  void addArmy(ArmyPathFinder a) {
    armyList.add(a);
  }

  boolean selectArmy(float x, float y) {
    ArmyPathFinder newSelectedArmy = null;

    for (ArmyPathFinder a : armyList) {
      PVector msp = a.army.meanSoldierPosition();
      if (dist(msp.x, msp.y, x, y)<armySelectorSize) {
          newSelectedArmy = a; 
          newSelectedArmy.wayPoints.clear();
          newSelectedArmy.nextPoint = null;
      }
    }
    selectedArmy = newSelectedArmy;

    return selectedArmy != null;
  }

  boolean moveArmy(float x, float y) {
    if (selectedArmy!=null) {
      selectedArmy.addWayPoint(x, y);
    }
    return    selectedArmy != null;
  }

  void updateWithZoomFactor() {
    armySelectorSize *= GameConstants.zoomFactor;
    for (ArmyPathFinder ap : this.armyList) {
      ap.updateWithZoomFactor();
    }
  }

  void updateMapPosition(float dx, float dy) {     
    for (ArmyPathFinder ap : armySelector.armyList) {
      ap.updateMapPosition(dx,dy);
    }
  }

  void update() {
    for (ArmyPathFinder a : armyList) {
      a.update();
    }
  }

  void drawSelector() {
    for (ArmyPathFinder a : armyList) {
      a.drawWayPoints(a == selectedArmy);

      //CENTER OF ARMY///////////////////////////
      PVector msp = a.army.meanSoldierPosition();
      noStroke();
      fill(30,0,0,100);
      if(a == selectedArmy) fill(255,255,0,100);
      ellipse(msp.x, msp.y, armySelectorSize, armySelectorSize);
      stroke(255,0,0);
      if(a == selectedArmy)textSize(30); else textSize(15); 
      text(a.army.name,msp.x+armySelectorSize/2, msp.y);
      text( ""+a.army.absolutPosition,msp.x+armySelectorSize/2, msp.y+30);
      text( "Start. "+ a.army.soldiers.size() + " Alive:"+a.army.armySizeAlive(),msp.x+armySelectorSize/2, msp.y+60);
      ///////////////////////////////////////////

    }

  }
}
