/*
The user object is referenced from the user position which is the left most part of the object
The lure is offset fro the RIGHT side of the userobject by a specified gap
All objects wrap around the fixed length space
The checkOverlap function must return true if the lure or the user is overlapping the static object 

*/



class userObject 
{
  int worldWidth;
  int userWidth; //  width
  int userPosition; // rect xposition
  int userHeight; // display height
  int lurePosition;
  int lureOffset;
  int lureWidth;
  int hue;
  int uBrightness = 255;
  int lBrightness = 120;
  int sBrightness = 180;
  color userCol; //the color of the user
  int staticPos;
  int staticWidth;
  int environmentStartX; //the screen location of the start of the environment - for drawing on the screen
  
  //remote data storage for variables from devices
  int ElapsedTime = 0;
  int XChange = 0;
  int YChange = 0;
  int buttonState = 0;
  int LEDBrightness = 0;
  int hapticStrength1 = 0;
  int hapticStrength2 = 0;
  
  //Constructor
  userObject(int uWidth, int uPos, int uHeight, int lOffset, int lWidth, int wWidth, int eOffset) { 
    worldWidth = wWidth;
    environmentStartX = eOffset; //offset for drawing on the screen
    userWidth = uWidth; //  width
    userHeight = uHeight; // display height
    lureWidth = lWidth;
    staticPos = 0;
    staticWidth = 3;
    lureOffset = lOffset;
    move(uPos); //more to the start position
  }
  //-----------------------------------------------------------------------
  int getUserStart(){
    return userPosition;
  }
  //-----------------------------------------------------------------------
  int getUserEnd(){
    return wrap(userPosition+userWidth);
  }
  //-----------------------------------------------------------------------
  int getLureStart(){
    return lurePosition;
  }
  //-----------------------------------------------------------------------
  int getLureEnd(){
    return wrap(lurePosition+lureWidth);
  }
  //-----------------------------------------------------------------------

  
  boolean checkSelfOverlap() {
    //returns true if the lure or user is on the static object
    //This does NOT work when the static object is wrapping around the environment
    //Check to see if they are NOT overlapping
    int userEnd = wrap(userPosition+userWidth);
    int staticEnd = wrap(staticPos+staticWidth);
    if(userEnd < userPosition && staticEnd > staticPos){ //handle wrapping around case for user but not static object
      if(userPosition > staticEnd && userEnd < staticPos) return false;
      return true;
    }
    if(userEnd > userPosition && staticEnd < staticPos){ //handle wrapping around case for static object but NOT user
      if(userPosition > staticEnd && userEnd < staticPos) return false;
      return true;
    }
    if(userEnd < userPosition && staticEnd < staticPos){ //handle wrapping around case for both objects
      return true;
    }
    if(userPosition > staticEnd || userEnd < staticPos) return false;
    return true;
  }
  //-----------------------------------------------------------------------
  
  void setHue(int newHue){
    hue = newHue;
    //userCol = color(hue, 255, 150);
  }
  void setBrightness(int ub, int lb, int sb){
    uBrightness = ub;
    lBrightness = lb;
    sBrightness = sb;
  }
  //-----------------------------------------------------------------------
  void setStaticPos(int sPos, int sWidth){
    staticPos = wrap(sPos);
    staticWidth = sWidth;
  }
  //-----------------------------------------------------------------------
 
  void move (int newPos) {
    userPosition = wrap(newPos);
    lurePosition = wrap( userPosition + userWidth + lureOffset );
  }
  //-----------------------------------------------------------------------
 
  void display(int yPos) {
    //brightnessDrop
    //draw on the screen using the yPos
    rectMode(CORNER);
    stroke(128);
    //rectMode(CENTER);
    stroke(0);
    fill(color(hue, 100, sBrightness));  // Set fill to userCol
    //draw the static object
    drawRectWrap(environmentStartX+staticPos, yPos, staticWidth, userHeight);
    //draw the users position
    fill(color(hue, 255, uBrightness));
    drawRectWrap(environmentStartX+userPosition, yPos, userWidth, userHeight);
    //draw the lure
    fill(color(hue, 150, lBrightness));
    drawRectWrap(environmentStartX+lurePosition, yPos, lureWidth, userHeight);
    //stroke(userCol);
    drawLineWrap(environmentStartX+userPosition+userWidth, lureOffset, yPos+(userHeight/2));
    //line(environmentStartX+userPosition+userWidth, yPos+(userHeight/2), environmentStartX+lurePosition, yPos+(userHeight/2));
  }
  //-----------------------------------------------------------------------
  void drawRectWrap(int xS, int yS, int xWidth, int yHeight){
    //draw a rectangle but make sure it wraps around the world edges
    int worldEnd = worldWidth+environmentStartX; //compensate for the offset
    //println(worldEnd);
    rectMode(CORNER);
    if(xS+xWidth < worldEnd && xS >= environmentStartX){
      //normal
      rect(xS, yS, xWidth, yHeight);
    }
    else{
      //split the rectangle in half and draw one at each end
      rect(xS, yS, worldEnd-xS, yHeight);
      rect(environmentStartX, yS, (xS+xWidth)-worldEnd, yHeight);
    }
  }
  //-----------------------------------------------------------------------
  void drawLineWrap(int xS, int lLength, int yHeight){
    //draw a line that wraps
    int worldEnd = worldWidth+environmentStartX; //compensate for the offset
    //println(worldEnd);
    
    if(xS+lLength < worldEnd && xS >= environmentStartX){
      line(xS, yHeight, xS+lLength, yHeight);
    }
    else{
      if(xS < worldEnd){
        line(xS, yHeight, worldEnd, yHeight);
        line(environmentStartX, yHeight, environmentStartX+(lLength-(worldEnd-xS)), yHeight);
      }
      else line(environmentStartX+(xS-worldEnd), yHeight, environmentStartX+(lLength-(worldEnd-xS)), yHeight);
    }
  }
  //-----------------------------------------------------------------------
  int wrap(int inPosition) {
    //wrap around the world limit
    if(inPosition < 0) return -inPosition % worldWidth;
    return inPosition % worldWidth;
  }
}