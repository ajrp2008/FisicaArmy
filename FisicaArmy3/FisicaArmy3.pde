import fisica.*;

FWorld            world;
ArmySelector      armySelector; 
Button            zoomInButton,zoomOutButton; 
Button            resetButton;
float             buttonHeight = 100, buttonWidth = 300, buttonGap =50, buttonTopGap = 50, buttonLeftGap = 50;



void setup(){
  size(1440,2960);
  //fullScreen();
  smooth();

  initGame();
  
  zoomInButton = new Button(width-(buttonWidth+buttonLeftGap), (buttonTopGap), buttonWidth, buttonHeight);
  zoomInButton.setText("Zoom In");
  
  zoomOutButton = new Button(width-(buttonWidth+buttonLeftGap), (buttonTopGap+buttonHeight+buttonGap), buttonWidth, buttonHeight);
  zoomOutButton.setText("Zoom Out");
  
    resetButton = new Button(width-(buttonWidth+buttonLeftGap), (buttonTopGap+3*buttonHeight+2*buttonGap), buttonWidth, buttonHeight);
  resetButton.setText("Reset");
}

void initGame(){
  Fisica.init(this);
  world = new FWorld();
  world.setGravity(0,0);
  ellipseMode(CENTER);
  GameConstants.initGameConstants();
  armySelector    = new ArmySelector();
  armySelector.addArmy(new ArmyMover(new SoldiersMover(100,100,"A",0,255,0)));
  armySelector.addArmy(new ArmyMover(new SoldiersMover(200,150,"B",255,255,255)));
  armySelector.addArmy(new ArmyMover(new SoldiersMover(100,200,"C",200,0,0)));  
  armySelector.addArmy(new ArmyMover(new SoldiersMover(400,100,"D",0,255,0)));
  armySelector.addArmy(new ArmyMover(new SoldiersMover(600,150,"E",255,255,255)));
  armySelector.addArmy(new ArmyMover(new SoldiersMover(400,200,"F",200,0,0)));
 //Initial zoom based on screen size
  zoomMap(4);
  
}

void draw(){
  background(100);
  //DEBUG TEXT 
  textSize(40); 
  fill(200,0,0);
   text("zoomFactorAccum: "+GameConstants.zoomFactorAccumulated,70,70);
  //  
  world.step();
  armySelector.drawSelector();
  armySelector.update();
  world.draw();
  //
  zoomInButton.display();
  zoomOutButton.display();
  resetButton.display();
}

void mousePressed(){
  if(zoomInButton.isPushed(mouseX,mouseY)){ zoomInButton_click();return;}
  if(zoomOutButton.isPushed(mouseX,mouseY)){ zoomOutButton_click(); return;}
  if(resetButton.isPushed(mouseX,mouseY)){ resetButton_click(); return;}

  boolean result = armySelector.selectArmy(mouseX,mouseY);
}

public void zoomInButton_click() {
  zoomMap(1.1);
}

public void zoomOutButton_click() {
  zoomMap(0.9);
}

public void resetButton_click(){
  initGame();
}

void mouseDragged(){
  if(zoomInButton.isPressed || zoomOutButton.isPressed  || resetButton.isPressed){return;}
  
  boolean result = armySelector.moveArmy(mouseX,mouseY);
  if(!result){
    moveMap(mouseX-pmouseX,mouseY-pmouseY);
  }
}

void mouseReleased(){
  zoomInButton.release();
  zoomOutButton.release();
  resetButton.release();
}

void zoomMap(float zoom){
  GameConstants.zoomFactor = zoom;
  GameConstants.zoomFactorAccumulated *=GameConstants.zoomFactor;
  armySelector.updateWithZoomFactor();
}

void moveMap(float dx, float dy){
  armySelector.updateMapPosition(dx,dy);
}


void contactStarted(FContact c) {
    if(!c.getBody1().getName().equals(c.getBody2().getName())){
     // c.getBody1().setFilterBits(1);
     // c.getBody2().setFilterBits(1);
      Soldier s1 = (Soldier)c.getBody1();
      Soldier s2 = (Soldier)c.getBody2();
      s1.army.contactStarted(c);
      s2.army.contactStarted(c);
    }
}
