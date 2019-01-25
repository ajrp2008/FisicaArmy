class ArmySelector {
  float                 armySelectorSize  = GameConstants.armySelectorSizeStart;

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
     
     // if(a==selectedArmy)continue;
      a.display(a == selectedArmy);
      //CENTER OF ARMY///////////////////////////
      PVector msp = a.soldierMover.meanSoldierPosition();
      noStroke();
      if(a == selectedArmy) fill(255,255,0,100);else fill(30,0,0,100);
      ellipse(msp.x, msp.y, armySelectorSize, armySelectorSize);
      stroke(255,0,0);
      if(a == selectedArmy){textSize(30); continue; }else textSize(15); 
      text(a.soldierMover.name,msp.x+armySelectorSize/2, msp.y);
      text( ""+a.soldierMover.absolutPosition,msp.x+armySelectorSize/2, msp.y+30);
      text( "Start. "+ a.soldierMover.soldiers.size() + " Alive:"+a.soldierMover.armySizeAlive(),msp.x+armySelectorSize/2, msp.y+60);
      text( a.moverState.toString(),msp.x+armySelectorSize/2, msp.y+90);
      text( a.soldierMover.armyState.toString(),msp.x+armySelectorSize/2, msp.y+120);
      text( "Approveroute:"+a.moverStateFollowPath.approveRoute,msp.x+armySelectorSize/2, msp.y+150);
      text( "nextpoint:"+a.moverStateFollowPath.nextPoint,msp.x+armySelectorSize/2, msp.y+180);
            text( "marching:"+a.soldierMover.isMarching(),msp.x+armySelectorSize/2, msp.y+210);
      ///////////////////////////////////////////
    }

  }
  
  void drawSelectedArmy(){
     ArmyMover a = selectedArmy;
      if(a==null)return;
      //CENTER OF ARMY///////////////////////////
     PVector msp = a.soldierMover.meanSoldierPosition();
      noStroke();
      stroke(255,0,0);
      rect(msp.x+armySelectorSize/2, msp.y-30-5,900,300);
            fill(255,255,0);
      textSize(30);
      text(a.soldierMover.name,msp.x+armySelectorSize/2, msp.y);
      text( ""+a.soldierMover.absolutPosition,msp.x+armySelectorSize/2, msp.y+30);
      text( "Start. "+ a.soldierMover.soldiers.size() + " Alive:"+a.soldierMover.armySizeAlive(),msp.x+armySelectorSize/2, msp.y+60);
      text( a.moverState.toString(),msp.x+armySelectorSize/2, msp.y+90);
      text( a.soldierMover.armyState.toString(),msp.x+armySelectorSize/2, msp.y+120);
      text( "Approveroute:"+a.moverStateFollowPath.approveRoute,msp.x+armySelectorSize/2, msp.y+150);
      text( "nextpoint:"+a.moverStateFollowPath.nextPoint,msp.x+armySelectorSize/2, msp.y+180);
            text( "marching:"+a.soldierMover.isMarching(),msp.x+armySelectorSize/2, msp.y+210);
      ///////////////////////////////////////////
    
  
  }
  
}
