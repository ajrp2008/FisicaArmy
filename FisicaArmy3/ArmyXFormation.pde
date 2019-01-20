void createSoldiers(SoldiersMover army) {
  for (int i=0; i<army.armySize; i++) {
    Soldier s = new Soldier(army, new PVector());
    s.setFill(army.r, army.g, army.b);
    army.soldiers.add(s);
  }
}


void initSquareFormation(SoldiersMover army) {
  for (int i=0; i<army.soldiers.size(); i++) {
    float length       = sqrt(army.soldiers.size());
    int column         = i%(int)length; 
    int row            = i/(int)length; 
    Soldier s = army.soldiers.get(i);
    s.relPosition.set((column-(length-1.0)/2.0)*GameConstants.armyGapSizeStart*GameConstants.zoomFactor, (row-(length-1)/2)*GameConstants.armyGapSizeStart*GameConstants.zoomFactor);
  }
}
