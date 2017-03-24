
//Serial Commands
#define REQUEST_DATA              'r'
#define REQUEST_DATA_SET_MESSAGE  'R'
#define START_TRIAL               's'
#define END_TRIAL                 'e'
#define SET_HAPTICS               'h'
#define SET_HAPTICS_SET_MESSAGE   'H'
#define QUERY_DEVICE              '?'


bool refreshSerial(){
  if( checkSerial() ){
    parseSerial();
    resetBuffer();
    return 1;
  }
  else return 0;
}

void resetBuffer(){
  newData = 0;
  bufferIndex = 0;
}

bool checkSerial(){
  while(USB.available()){
    serialBuffer[bufferIndex] = USB.read();
    bufferIndex++;
    if(serialBuffer[bufferIndex-1] == NEWLINE || serialBuffer[bufferIndex-1] == RETURN){
      if(bufferIndex < 2){
        //reset if it is only a newline or return
        bufferIndex = 0;
        //USB.println("Resetting buffer");
        return 0;
      }
      newData = 1;
      serialBuffer[bufferIndex] = '\0';
      //USB.println("New Data");
      return 1;
    }
  }
  return 0;
}

void parseSerial(){
  switch(serialBuffer[SERIAL_COMMAND]){
    case REQUEST_DATA:
      
      //USB.println("Print cmd");
      printData();
      break;
    case REQUEST_DATA_SET_MESSAGE:
      //USB.println("Print Set cmd");
      printData();
      extractMessage(1);
      printMessage();

     // printData2();
      
      break;
    case START_TRIAL:
      //USB.println("Start cmd");
      extractMessage(1);
      startTrial();
      sendACK();
      break;
    case END_TRIAL:
      //USB.println("End cmd");
      extractMessage(1);
      stopTrial();
      sendACK();
      break;
    case SET_HAPTICS:
      //USB.println("Haptics cmd");
      parseHapticCommand();
      setHaptics();
      sendACK();

      //printData2();
      
      break;
    case SET_HAPTICS_SET_MESSAGE:
      //USB.println("Haptics Set msg cmd");
      parseHapticMessageCommand();
      setHaptics();
      printMessage();

      //printData2();
      
      break;
    case QUERY_DEVICE:
    
      //USB.println("Query cmd");
      sendACK();
      break;
  }
}

void parseHapticCommand(){
  int i = 0;
  const char s[2] = ",";
  char *token;
   
  /* get the first token */
  token = strtok(&serialBuffer[1], s);
  if(token == NULL) return;
  hapticRate1 = atoi(token); //get hatic rate 1
  
  token = strtok(NULL, s);
  if(token == NULL) return;
  hapticRate2 = atoi(token); //get haptic 2 rate
}


void parseHapticMessageCommand(){
  const char s[2] = ",";
  char *token;
   
  /* get the first token */
  token = strtok(&serialBuffer[1], s);
  if(token == NULL) return;
  hapticRate1 = atoi(token); //get hatic rate 1
  
  token = strtok(NULL, s);
  if(token == NULL) return;
  hapticRate2 = atoi(token); //get haptic 2 rate
  
  token = strtok(NULL, s);
  if(token == NULL) return;
  for(int n = 0; n < 32; n++){
    LCDText[n] = token[n];
    if(LCDText[n] == '\0') break;
  } //get message
}

void extractMessage(int startIndex){
  //assumes that the message ends with NULL
  for(int n = 0; n < 32; n++){
    LCDText[n] = serialBuffer[n+startIndex];
    if(LCDText[n] == '\0') return;
  }
}

void sendACK(){
  USB.println("OK");
  
  USB.send_now();
}
void sendNACK(){
  USB.println("ERR");
  
  USB.send_now();
}
