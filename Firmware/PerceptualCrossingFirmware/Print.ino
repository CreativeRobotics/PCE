
void printData(){
  //print a standard data packet
  //Collect the variables for encoders now so they don't change half way through the print functions
  //Send encoder values as a relative change since the last time
  //long printStart = micros();
  //TIME TEST - from here until USB.send_now() returns takes 95 microseconds
  long tempX;
  long tempY;
  long xChange, yChange;
  unsigned long elapsedTime;
  boolean tempButtonState = 0;
  int tempLEDVal = 0;
  //capture the encoder states
  tempX = xCountTotal;
  tempY = yCountTotal;

  //work out the change
  xChange = tempX-oldXCount;
  yChange = tempY-oldYCount;
  //copy button and LED states
  tempButtonState = buttonState;
  tempLEDVal = LEDBrightness;
  //Get elapsed Time
  elapsedTime = dataSendTimer;
  dataSendTimer = 0;
  //update the old values to the new ones.
  oldXCount = tempX;
  oldYCount = tempY;


  String xData = xChange;
  String yData = yChange;
  String buttonStateData = buttonState;
  String ledValData = tempLEDVal;
  String elapsedT = elapsedTime;
  String data = elapsedT + ',' + xData + ',' + yData + ',' + buttonStateData + ',' + ledValData;
  
  USB.println(data);
  USB.send_now(); //this stops interrupts happening
  //USB.println(micros()-printStart);
  /*USB.print(elapsedTime);
  USB.write(COMMA); USB.print(xChange);
  USB.write(COMMA); USB.print(yChange);
  USB.write(COMMA); 
  if(tempButtonState) USB.print("ON");
  else USB.print("OFF");
  USB.write(COMMA); 
  USB.print(tempLEDVal);
  USB.println();*/
}

void printData2(){
  
                    USB.print(hapticRate1);
  USB.write(COMMA); USB.print(hapticRate2);
  USB.write(COMMA); USB.print(LCDText);
  USB.println();
}

