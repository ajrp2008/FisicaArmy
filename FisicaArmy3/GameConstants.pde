static class GameConstants{
  
  static float soldierSpeedStart;
  static float soldierSizeStart;
  static float armyGapSizeStart;
  static float wayPointGapStart;
  static float armySelectorSizeStart;
  static float zoomFactor;
  static float zoomFactorAccumulated;
  static String debugText;
  
  
  static void initGameConstants(){
    //INITIAL CONDITIONS
    soldierSpeedStart       = 30;
  
    soldierSizeStart        = 4;
    armyGapSizeStart        = 6;
    wayPointGapStart        = 50;
  
    armySelectorSizeStart   = 50;
  
    zoomFactor              = 1;
    zoomFactorAccumulated   = GameConstants.zoomFactor;
  
    debugText              = "DEBUG";
  }

}
