
/*void initSerial(){
  if(surpressSerialA) return;
  // create two serial ports - these need to be checked so that we know which actual ports to use after they are installed.
  String portNameA;
  String portNameB;
  portNameA = "COM9"; //USB
  portNameB = "COM10"; //USB
  //myPort = new Serial(this, portName, 115200);
  myPortA = new Serial(this, portNameA, 921600);
  myPortA.bufferUntil(NEWLINE);
  
  myPortB = new Serial(this, portNameB, 921600);
  myPortB.bufferUntil(NEWLINE);
}*/



void sendDataPortA(String dataLine){
  //if(serialDisconnected == true) return;
  //println(dataLine);
  if(myPortA != null) {
    myPortA.write(dataLine);
    if(debugPrintA) println("SentA:"+dataLine);
  }
}

void sendDataPortB(String dataLine){
  //if(serialDisconnected == true) return;
  //println(dataLine);
  if(myPortB != null) {
    myPortB.write(dataLine);
    if(debugPrintB) println("SentB:"+dataLine);
  }
}

void connectPortA(){
     // get the first available port (use EITHER this OR the specific port code below)
    String portName = portList[portAIndex];
    println(portName);
    // open the serial port
    myPortA = new Serial(this, portName, 115200); 
    serialAConnected = true;
    int nl = 10;      // ASCII linefeed
    myPortA.bufferUntil(nl);
    println("Connected A to " + portName);
}

void connectPortB(){
     // get the first available port (use EITHER this OR the specific port code below)
    String portName = portList[portBIndex];
    println(portName);
    // open the serial port
    myPortB = new Serial(this, portName, 115200); 
    serialBConnected = true;
    int nl = 10;      // ASCII linefeed
    myPortB.bufferUntil(nl);
    println("Connected B to " + portName);
}

void disconnectPortA(){
  myPortA.stop();
  myPortA = null;
  serialAConnected = false;
  println("Disconnected A");
}

void disconnectPortB(){
  myPortB.stop();
  myPortB = null;
  serialBConnected = false;
  println("Disconnected B");
}


void serialEvent(Serial port) {
  if(debugPrintA || debugPrintB) println("Serial Event:" + port);
  if(port == myPortA) serialEventHandlerA();
  if(port == myPortB) serialEventHandlerB();
}

void serialEventHandlerA(){
  try {
    if(debugPrintA) print("Trying A ");
    if(myPortA != null) {
      if(debugPrintA) print("In A ");
      String serialLine = myPortA.readString();
      //println(serialLine);
      if (serialLine != null){
        
          //if(debugPrint) println("String not NULL");
          serialALinesReceived++;
          //parse the data
          parseLineA( serialLine );
          //cp5.get(Textlabel.class,"SerialAText").setText(serialLine);
          //logDataA(serialLine); //log the data if requested
      }
      //else if(debugPrint) println("Null serial string A");
    }
  }
  catch(RuntimeException e) {
    if(debugGeneral) println("SerialA Error " + e);
    //if(myPortA == null) println("Port A NULL");
    errorCountA++;
  }     
}
    
    
void serialEventHandlerB(){
  try {
    if(debugPrintB) print("Trying B ");
    if(myPortB != null) {
      if(debugPrintB) print("In B ");
      String serialLine = myPortB.readString();
      //if(serialLine == null && debugPrintB) println("NULL ");
      if (serialLine != null){
          if(debugPrintB) println(serialLine);
          serialBLinesReceived++;
          parseLineB( serialLine );
          //cp5.get(Textlabel.class,"SerialBText").setText(serialLine);
          //logDataB(serialLine); //log the data if requested
      }
      else if(debugPrintB) println("Null serial string B");
    }
  }
  catch(RuntimeException e) {
    if(debugGeneral) println("SerialB Error " + e);
    errorCountB++;
  }   
}


void parseLineA(String parseThis){
  //if(debugPrintA) println("Parsing . . . " + parseThis);
  if(parseThis.length() < 2) return;
  String delims = "[ ,=\r\n]+"; 
  String[] tokens = parseThis.split(delims);
  //tokens is now an array of items.
  if(tokens[0] == "OK"){//ACK
    if(debugPrintA) print("Recieved ACK A");
    waitingForA = false;
  }
  else if(tokens[0] == "ERR"){//NACK
    if(debugPrintA) print("Recieved ERR A");
    errorCountA++;
    waitingForA = false;
  }
  else if(tokens.length == 5){
    
    //if(debugPrint) print("Unpacking ");
    //There is only one data packet type, so parse it into appropriate variables
    userA.ElapsedTime = Integer.parseInt(tokens[0]);
    if(debugPrintA) {print(userA.ElapsedTime);print("  ");}
    
    userA.XChange = Integer.parseInt(tokens[1]);
    if(debugPrintA) {print(userA.XChange);print("  ");}
    
    userA.YChange = Integer.parseInt(tokens[2]);
    if(debugPrintA) {print(userA.YChange);print("  ");}
    
    userA.buttonState = Integer.parseInt(tokens[3]);
    if(debugPrintA) {print(userA.buttonState);print("  ");}

    userA.LEDBrightness = Integer.parseInt(tokens[4]);
    if(debugPrintA) { print(userA.LEDBrightness);print("  ");}
    
    setReplyStateA_OK();
  }
  if(debugPrintA) println(" Done");
}

void setReplyStateA_OK(){ 
    newDataFromA = true;
    waitingForA = false;
} 
  
    
void parseLineB(String parseThis){
  //if(debugPrintA) println("Parsing . . . " + parseThis);
  if(parseThis.length() < 2) return;
  String delims = "[ ,=\r\n]+"; 
  String[] tokens = parseThis.split(delims);
  //tokens is now an array of items.
  if(tokens[0] == "OK"){//ACK
    if(debugPrintB) print("Recieved ACK B");
    waitingForB = false;
  }
  else if(tokens[0] == "ERR"){//NACK
    if(debugPrintB) print("Recieved ERR B");
    errorCountB++;
    waitingForB = false;
  }
  else if(tokens.length == 5){
    
    //if(debugPrint) print("Unpacking ");
    //There is only one data packet type, so parse it into appropriate variables
    userB.ElapsedTime = Integer.parseInt(tokens[0]);
    if(debugPrintB) {print(userB.ElapsedTime);print("  ");}
    
    userB.XChange = Integer.parseInt(tokens[1]);
    if(debugPrintB) {print(userB.XChange);print("  ");}
    
    userB.YChange = Integer.parseInt(tokens[2]);
    if(debugPrintB) {print(userB.YChange);print("  ");}
    
    userB.buttonState = Integer.parseInt(tokens[3]);
    if(debugPrintB) {print(userB.buttonState);print("  ");}
    
    userB.LEDBrightness = Integer.parseInt(tokens[4]);
    if(debugPrintB) { print(userB.LEDBrightness);print("  ");}
    
    setReplyStateB_OK();
  }
  if(debugPrintB) println(" Done");
}

void setReplyStateB_OK(){ 
    newDataFromB = true;
    waitingForB = false;
} 
  
    
    