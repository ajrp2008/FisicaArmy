interface SoldiersMoveState{
  
    void commandArmyPosition(float x, float y);

    void commandArmyHeading(float x, float y);
    
    void updateArmySoldiers();
    
    void updateState();
    
    boolean isMarching();
    
    void contactStarted(FContact c);
    
    void retreatTo(float x, float y);
    
    void updateArmyToZoom();
    
}
