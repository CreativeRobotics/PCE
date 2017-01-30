
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



void sendData(String dataLine){
  //if(serialDisconnected == true) return;
  if(myPortA != null) myPortA.write(dataLine);
}

void connectPortA(){
     // get the first available port (use EITHER this OR the specific port code below)
    String portName = portList[portAIndex];
    println(portName);
    // open the serial port
    myPortA = new Serial(this, portName, 38400); 
    serialAConnected = true;
    int nl = 10;      // ASCII linefeed
    myPortA.bufferUntil(nl);
    println("Connected to " + portName);
}

void connectPortB(){
     // get the first available port (use EITHER this OR the specific port code below)
    String portName = portList[portBIndex];
    println(portName);
    // open the serial port
    myPortB = new Serial(this, portName, 38400); 
    serialBConnected = true;
    int nl = 10;      // ASCII linefeed
    myPortB.bufferUntil(nl);
    println("Connected to " + portName);
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
  if(port == myPortA) serialEventHandlerA();
  else if(port == myPortB) serialEventHandlerB();
}

void serialEventHandlerA(){
  try {
    if(myPortA != null) {
      String serialLine = myPortA.readString();
      //println(serialLine);
      if (serialLine != null){
          serialABytesRecieved++;
          //parseLineA( serialLine );
          cp5.get(Textlabel.class,"SerialAText").setText(serialLine);
          logDataA(serialLine); //log the data if requested
      }
    }
  }
  catch(RuntimeException e) {
    println("SerialA Error");
  }     
}
    
    
void serialEventHandlerB(){
  try {
    if(myPortB != null) {
      String serialLine = myPortA.readString();
      //println(serialLine);
      if (serialLine != null){
          serialABytesRecieved++;
          //parseLineA( serialLine );
          cp5.get(Textlabel.class,"SerialBText").setText(serialLine);
          logDataB(serialLine); //log the data if requested
      }
    }
  }
  catch(RuntimeException e) {
    println("SerialA Error");
  }   
}


void parseLineA(String parseThis){
  int parsedItems = 0;
  char idChar = parseThis.charAt(0);
  println("Char 0="+idChar);
  if(idChar != 'q' && idChar != 'r' && idChar != 'y')  return;
  if(parseThis.length() < 3) return;
  //println("New Data");
  String dataString = parseThis.substring(1);
  String delims = "[ ,=\r\n]+"; 
  String[] tokens = dataString.split(delims);
  //tokens is now an array of numbers so parse them to floats
  for(parsedItems = 0; parsedItems < tokens.length; parsedItems++){
    if(parsedItems > 15) return;
    //incomingData[parsedItems] = Float.parseFloat(tokens[parsedItems]);
    //println("Value Parsed " + incomingData[parsedItems] );
  }

}
    
    
  
    
    
    