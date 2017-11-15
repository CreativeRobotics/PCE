//data comms
//Serial Commands
char REQUEST_DATA             =  'r';
char REQUEST_DATA_SET_MESSAGE =  'R';
char START_TRIAL              =  's';
char END_TRIAL                =  'e';
char SET_HAPTICS              =  'h';
char SET_HAPTICS_SET_MESSAGE  =  'H';

//Commands with data are ALL comma seperated
//e.g H100,100,MyMessage

//NOTE - response time is around 200,000 nanoseconds between requesting data and getting it back

//=========================================================================

void getState(int unitNo){
  if(unitNo < 1 || unitNo > 2)  return;
  String message = 'r' + String.valueOf(NEWLINE);
  if(unitNo == 1) {
    sendDataPortA(message);
    waitingForA = true;
  }
  else{
    sendDataPortB(message);
    waitingForB = true;
  }
}
//=========================================================================

void getStateSetMessage(int unitNo, String lcdMessage){
  if(unitNo < 1 || unitNo > 2)  return;
  String message = 'R' + lcdMessage + String.valueOf(NEWLINE);
  
  if(unitNo == 1) {
    sendDataPortA(message);
    waitingForA = true;
  }
  else{
    sendDataPortB(message);
    waitingForB = true;
  }
}
//=========================================================================

void queryDevice(int unitNo){
  if(unitNo < 1 || unitNo > 2)  return;
  String message = '?' + String.valueOf(NEWLINE);
  
  if(unitNo == 1) sendDataPortA(message);
  else sendDataPortB(message);
}
//=========================================================================

void sendStartTrial(int unitNo, String lcdMessage){
  if(unitNo < 1 || unitNo > 2)  return;
  String message = 's' + lcdMessage + String.valueOf(NEWLINE);
  
  if(unitNo == 1) {
    sendDataPortA(message);
    waitingForA = true;
  }
  else{
    sendDataPortB(message);
    waitingForB = true;
  }
}

//=========================================================================

void sendEndTrial(int unitNo, String lcdMessage){
  if(unitNo < 1 || unitNo > 2)  return;
  String message = 'e' + lcdMessage + String.valueOf(NEWLINE);
  
  if(unitNo == 1) {
    sendDataPortA(message);
    waitingForA = true;
  }
  else{
    sendDataPortB(message);
    waitingForB = true;
  }
}
//=========================================================================

//Send ... LED ON, LED OFF, Beep ON, Beep OFF.
//#define LED_ON                    'L'
//#define LED_OFF                    'l'
//#define BEEP_ON                    'B'
//#define BEEP_OFF                  'b'
void sendLedOn(int unitNo){
  if(unitNo < 1 || unitNo > 2)  return;
  String message = 'L' + String.valueOf(NEWLINE);
  if(unitNo == 1)  sendDataPortA(message);
  else             sendDataPortB(message);
}
//=========================================================================
void sendLedOff(int unitNo){
  if(unitNo < 1 || unitNo > 2)  return;
  String message = 'l' + String.valueOf(NEWLINE);
  if(unitNo == 1)  sendDataPortA(message);
  else             sendDataPortB(message);
}
//=========================================================================
void sendBeepOn(int unitNo){
  if(unitNo < 1 || unitNo > 2)  return;
  String message = 'B' + String.valueOf(NEWLINE);
  if(unitNo == 1)  sendDataPortA(message);
  else             sendDataPortB(message);
}
//=========================================================================
void sendBeepOff(int unitNo){
  if(unitNo < 1 || unitNo > 2)  return;
  String message = 'b' + String.valueOf(NEWLINE);
  if(unitNo == 1)  sendDataPortA(message);
  else             sendDataPortB(message);
}
//=========================================================================

void ledBeepOn(){
  sendLedOn(1);
  sendLedOn(2);
  sendBeepOn(1);
  sendBeepOn(2);
}
void ledBeepOff(){
  sendLedOff(1);
  sendLedOff(2);
  sendBeepOff(1);
  sendBeepOff(2);
}

void setHaptics(int unitNo){
  if(unitNo == 1) {
    String message = 'h' + String.valueOf(userA.hapticStrength1) + ',' + String.valueOf(userA.hapticStrength2) + String.valueOf(NEWLINE);
    sendDataPortA(message);
    //print("Haptics Sent A:");
    //println(message);
  }
  if(unitNo == 2) {
    String message = 'h' + String.valueOf(userB.hapticStrength1) + ',' + String.valueOf(userB.hapticStrength2) + String.valueOf(NEWLINE);
    sendDataPortB(message);
    //print("Haptics Sent B:");
    //println(message);
  }
}

void setHapticsSetMessage(int unitNo, String lcdMessage){
  if(unitNo < 1 || unitNo > 2)  return;
  if(unitNo == 1) {
    String message = 'H' + String.valueOf(userA.hapticStrength1) + ',' + String.valueOf(userA.hapticStrength2) + ',' + lcdMessage + String.valueOf(NEWLINE);
    sendDataPortA(message);
  }
  else {
    String message = 'H' + String.valueOf(userB.hapticStrength1) + ',' + String.valueOf(userB.hapticStrength2) + ',' + lcdMessage + String.valueOf(NEWLINE);
    sendDataPortB(message);
  }
}