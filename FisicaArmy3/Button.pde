class Button{
 
  float x,y,w,h;
  float r=100,g=0,b=0;
  String text;
  
  Button(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void display(){
    fill(r,g,b);
    rect(x,y,w,h,20);
  }
  
  void setText(String text){
    this.text = text;
  }

  void release(){
    g=0;
  }
  
  boolean isPushed(float x, float y){
    boolean isClicked = ((this.x < x && (this.x+w)>x))&(this.y < y && (this.y + h) > y);
    if(isClicked){g=200;}
    return isClicked;
  }
  
  
  
  
}
  
