//Perceptual Crossing Experiment

import controlP5.*;
import processing.serial.*;
userObject userA;


userObject userB;

int test1 = 0;
long timeTest = 0;
void setup()
{
  size(1200, 640);//, P2D);
  colorMode(HSB);
  myFont = createFont("Courier New", 14);
  startBX = width-(10+listBoxWidth);
  textFont(myFont);
  
  pfont = createFont("Arial",16,true); // use true/false for smooth/no-smooth
  largeFont = new ControlFont(pfont,241);
  
  cp5 = new ControlP5(this);
  
  portList = Serial.list();
  initialiseControls();
  
  envWidth = 600; //environment width
  envStart = (width/2) - (envWidth/2); //The distance from the screen edge that tne environment starts
  envYPos = 300; //environment Y Position onscreen
  //Arguments for user constructor: user width,  user starting position,  Y offset on screen for display, lure offset, lure width, environment width, environment x position onscreen for display
  userA = new userObject(4, userAPos, -20, 150, 4, envWidth, envStart); //create user A, lure and lure offset
  userA.setHue(userAHue);//set the colour for this user
  userA.setBrightness(userBrightness, lureBrightness, staticBrightness);//set the brightness settings for this users display elements
  userA.setStaticPos(150, 4);//set the position of the static object. Arguments: Position and object width
  
  userB = new userObject(4, userBPos, 20, 150, 4, envWidth, envStart); //create user B, lure and lure offset
  userB.setHue(userBHue);//set the colour for this user
  userB.setBrightness(userBrightness, lureBrightness, staticBrightness);//set the brightness settings for this users display elements
  userB.setStaticPos(450, 4); //set the position of the static object
  
  frameRate(systemFrameRate);
  //startTime = System.nanoTime();
  //startTime = System.currentTimeMillis();
  //oldTime = startTime;
 // trialActive = true;
}

void draw()
{
  background(200);

  if(MOUSE_TEST_MODE == true){
    if (mousePressed == true) {
       if (mouseButton == LEFT) userAPos = mouseX;
       if (mouseButton == RIGHT) userBPos = mouseX;
    }
    
    updateEnvironment();
    drawGraphics();
    stroke(0);
    fill(0);
  }
  else if(practiceMode == true){
    updatePractice();

  }

  if(trialActive == true) {
    //halt the loop and stop drawing on the screen
    //Any keyboard input now will hald the trial
    noLoop();
    startLogs();
    sendStartTrial(1, "Starting");
    sendStartTrial(2, "Starting");
    //thread("runTrial");
    runTrial();
    stopLogs();
    //runTrial only returns at the end of the trial
    trialActive = false;
    loop();
    practiceMode = false;
  }
}


void drawCollisions(){
  drawCollissionIndicator(userATouchingStatic, userATouchingLure, bothUsersTouching, userAHue, -10);
  drawCollissionIndicator(userBTouchingStatic, userBTouchingLure, bothUsersTouching, userBHue, 10);
}

void drawCollissionIndicator(boolean flag1, boolean flag2, boolean flag3, int userHue, int yOffset){
  //YOffset tells you what side to draw - top (-) or bottom (+)
  int centre = envStart+(envWidth/2);
  int start = envStart;
  int end = envStart+envWidth;
  int yStart = yOffset;
  int yEnd = yOffset;
  int indicatorWidth = 100;
  if(yOffset < 0){
    yStart = envYPos-(envHeight/2);
    yEnd = -10;
  }   else{
    yStart = envYPos+(envHeight/2);
    yEnd = 10;
  }
  
  if(flag1)fill(color(userHue, 150, staticBrightness)); //Static contact
  else fill(color(userHue, 10, 250));
  rect(start, yStart, indicatorWidth, yEnd);
  
  if(flag2) fill(color(userHue, 150, lureBrightness));//Lure contact
  else      fill(color(userHue, 10, 250));
  rect(start+indicatorWidth, yStart, indicatorWidth, yEnd);
 
  if(flag3) fill(color(userHue, 150, userBrightness));//User contact
  else fill(color(userHue, 10, 250));
  rect(start+indicatorWidth+indicatorWidth, yStart, indicatorWidth, yEnd);
}

void drawEnviron(){
    rectMode(CORNER);
    
    stroke(0);
    fill(255);  // Set fill to userCol
    rect(envStart, 300-(envHeight/2), envWidth, envHeight );
}

void drawGraphics(){
  drawEnviron();  
  userA.display(envYPos-1);
  userB.display(envYPos+1);
  drawCollisions();
}