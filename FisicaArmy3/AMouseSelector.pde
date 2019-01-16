class ArmySelector {
  float                     armySelectorSize   = GameConstants.armySelectorSizeStart;

  ArmyPathFinder             selectedArmy      = null;
  ArrayList<ArmyPathFinder>  armyList          = new ArrayList<ArmyPathFinder>();

  void addArmy(ArmyPathFinder a) {
    armyList.add(a);
  }

  boolean selectArmy(float x, float y) {
    ArmyPathFinder targetArmy = null;

    for (ArmyPathFinder a : armyList) {
      PVector msp = a.army.meanSoldierPosition();

      if (dist(msp.x, msp.y, x, y)<armySelectorSize) {
        if (selectedArmy != null && !a.wayPoints.isEmpty()) {
          targetArmy = a; 
          targetArmy.wayPoints.clear();
        } else {
          targetArmy = a;
        }
      }
    }
    selectedArmy = targetArmy;

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
      a.drawWayPoints();

      //CENTER OF ARMY///////////////////////////
      PVector msp = a.army.meanSoldierPosition();
      fill(30);
      ellipse(msp.x, msp.y, armySelectorSize, armySelectorSize);
      ///////////////////////////////////////////

      //ellipse(a.army.absolutPosition.x,a.army.absolutPosition.y,70,70);
    }
    if (selectedArmy!=null && selectedArmy.wayPoints.isEmpty()) {
      PVector p =selectedArmy.army.absolutPosition;
      noFill();
      stroke(255, 0, 0);
      ellipse(p.x, p.y, 40, 40);
    }
  }
}
