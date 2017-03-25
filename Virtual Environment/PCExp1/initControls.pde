void initialiseControls(){
setupLog();
setupListBoxes();
setupConnectButtons();
//setupSerialDisplay();
setupCommandButtons();
//setupPracticeButtons();
}

void setupLog(){
  int cCentre = width/2;
  int bWidth = 100;
  
  /*cp5.addToggle("LogDataButton")
     .setBroadcast(false)
     .setPosition(cCentre-(bWidth/2), startAY)
     .setSize(bWidth,30)
     .setValue(false)
     .setMode(ControlP5.DEFAULT)
     .setLabel("Start Log") 
     .setLabelVisible(true)  
     .setBroadcast(true)
     ;*/
     
}

void setupConnectButtons(){

  cp5.addToggle("ConnectAButton")
     .setBroadcast(false)
     .setPosition(startAX, startAY)
     .setSize(100,30)
     .setValue(false)
     .setMode(ControlP5.DEFAULT)
     .setLabel("Connect") 
     .setLabelVisible(true)  
     .setBroadcast(true)
     ;
  cp5.addToggle("ConnectBButton")
     .setBroadcast(false)
     .setPosition(startBX, startBY)
     .setSize(100,30)
     .setValue(false)
     .setMode(ControlP5.DEFAULT)
     .setLabel("Connect") 
     .setLabelVisible(true)  
     .setBroadcast(true)
     ;
}

void setupCommandButtons(){
  int buttonW = 300;
  int buttonH = 50;
  int vPos = 10;
  int vSpace = buttonH+5;
  int centreStart = (width/2)-(buttonW/2);
  
  int fSize = 15;
     
  /*cp5.addButton("ResetTimer")
     .setBroadcast(false)
     .setValue(0)
     .setPosition(centreStart, vPos)
     .setSize(buttonW, buttonH)     
     .setBroadcast(true)
     ;
  vPos += vSpace;*/
  cp5.addButton("NoPractice")
     .setBroadcast(false)
     .setValue(0)
     .setPosition(centreStart, vPos)
     .setSize(buttonW, buttonH)  
     .setBroadcast(true)
     .getCaptionLabel()
     .setFont(largeFont)
     .toUpperCase(false)
     .setSize(fSize)
     ;
   vPos += vSpace;
  cp5.addButton("FreePractice")
     .setBroadcast(false)
     .setValue(0)
     .setPosition(centreStart, vPos)
     .setSize(buttonW, buttonH)  
     .setBroadcast(true)
     .getCaptionLabel()
     .setFont(largeFont)
     .toUpperCase(false)
     .setSize(fSize)
     ;
   vPos += vSpace;
   cp5.addButton("Practice1")
     .setBroadcast(false)
     .setValue(0)
     .setPosition(centreStart, vPos)
     .setSize(buttonW, buttonH)  
     .setBroadcast(true)
     .getCaptionLabel()
     .setFont(largeFont)
     .toUpperCase(false)
     .setSize(fSize)
     ;
   vPos += vSpace;
   cp5.addButton("Practice2")
     .setBroadcast(false)
     .setValue(0)
     .setPosition(centreStart, vPos)
     .setSize(buttonW, buttonH)  
     .setBroadcast(true)
     .getCaptionLabel()
     .setFont(largeFont)
     .toUpperCase(false)
     .setSize(fSize)
     ;
   vPos += vSpace;
   cp5.addButton("Practice3")
     .setBroadcast(false)
     .setValue(0)
     .setPosition(centreStart, vPos)
     .setSize(buttonW, buttonH)  
     .setBroadcast(true)
     .getCaptionLabel()
     .setFont(largeFont)
     .toUpperCase(false)
     .setSize(fSize)
     ;
   vPos += vSpace;
   vPos += vSpace;
  cp5.addButton("StartTrial")
     .setBroadcast(false)
     .setValue(0)
     .setPosition(centreStart, vPos)
     .setSize(buttonW, buttonH)  
     .setBroadcast(true)
     .getCaptionLabel()
     .setFont(largeFont)
     .toUpperCase(false)
     .setSize(fSize)
     ;
 /* vPos += vSpace;
  cp5.addButton("PracticeSession")
     .setBroadcast(false)
     .setValue(0)
     .setPosition(centreStart, vPos)
     .setSize(buttonW, buttonH)  
     .setBroadcast(true)
     .getCaptionLabel()
     .setFont(largeFont)
     .toUpperCase(false)
     .setSize(fSize-2)
     ;*/
}


void setupListBoxes(){
  int startPos = startAY+50;
  cp5.addScrollableList("COMMPortA")
     .setPosition(startAX, startPos)
     .setSize(listBoxWidth, listBoxHeight)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(portList)
     .setType(ScrollableList.DROPDOWN ) // currently supported DROPDOWN and LIST
     .close()
     ;
     
  cp5.addScrollableList("COMMPortB")
     .setPosition(startBX, startPos)
     .setSize(listBoxWidth, listBoxHeight)
     .setBarHeight(20)
     .setItemHeight(20)
     .addItems(portList)
     .setType(ScrollableList.DROPDOWN ) // currently supported DROPDOWN and LIST
     .close()
     ;
}

void setupSerialDisplay(){

  serialTextA = cp5.addTextlabel("SerialTextA")
                    .setText("SerialDataA")
                    .setPosition(10,400)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",16))
                    ;
  serialTextB = cp5.addTextlabel("SerialTextB")
                    .setText("SerialDataB")
                    .setPosition(10,450)
                    .setColorValue(0xffffff00)
                    .setFont(createFont("Georgia",16))
                    ;
}

//button event handlers
/*void LogDataButton(boolean theFlag) {
  if(theFlag == true) {
    startLogs();
    cp5.getController("LogDataButton").setLabel("Stop Log");
  }
  if(theFlag == false)  {
    stopLogs();
    cp5.getController("LogDataButton").setLabel("Start Log");
  }
}*/

void ConnectAButton(boolean theFlag){
  if(theFlag == true) {
    //port = new Serial(this, portName, 115200);
    cp5.getController("ConnectAButton").setLabel("CONNECTED");
    connectPortA();
  }
  if(theFlag == false){
    cp5.getController("ConnectAButton").setLabel("Connect");
    disconnectPortA();
  }
}

void ConnectBButton(boolean theFlag){
  if(theFlag == true) {
    //port = new Serial(this, portName, 115200);
    cp5.getController("ConnectBButton").setLabel("CONNECTED");
    connectPortB();
  }
  if(theFlag == false){
    cp5.getController("ConnectBButton").setLabel("Connect");
    disconnectPortB();
  }
}

void COMMPortA(int n) {
//list box handler
   portAIndex = n;
}

void COMMPortB(int n) {
//list box handler
   portBIndex = n;
}

public void StartTrial(int theValue){
  trialActive = true;
  practiceIterations = 0;
  practiceMode = 0;
}

public void FreePractice(int theValue){
  practiceMode = 4;
  practiceIterations = 0;
  randomise();
}
public void Practice1(int theValue){
  practiceMode = 1;
  practiceIterations = 0;
  randomise();
}
public void Practice2(int theValue){
  practiceMode = 2;
  practiceIterations = 0;
  randomise();
}
public void Practice3(int theValue){
  practiceMode = 3;
  practiceIterations = 0;
  randomise();
}
public void NoPractice(int theValue){
  practiceMode = 0;
  practiceIterations = 0;
  userA.hapticStrength1 = 0;
  userB.hapticStrength1 = 0;
  setHaptics(1);
  setHaptics(2);
  //println("NOT");
}