//#include <Haptics.h>
#include <LiquidCrystalFast.h>
#include "Variables.h"
#include "Pins.h"

unsigned long iterations = 0;

LiquidCrystalFast lcd(LCDRS, LCDRW, LCDEN, LCD4, LCD5, LCD6, LCD7);

void setup() {
  analogWriteResolution(10);
  analogWriteFrequency(H1PWMPIN, HPWMFreq);
  initPins();
  initSerial();
  initLCD(); //hangs here
  //haptic1.initialise(H1PWMPIN, H1ENABLE);
  //haptic2.initialise(H2PWMPIN, H2ENABLE);

  beepX(500);
  userLED_ON();
  //USB.println("Started . . .");
  delay(1000);
  
  sendACK();
  userLED_OFF();
  startTrackerball();
  //setVib1Strength(0);
}

void loop() {
  //USB.print(iterations);
  //USB.print(' ');
  //printData();
  updateSystem();
  //userLED_ON();
  ///setUserLED(LEDBrightness);
  //LEDBrightness += 16;
  //if(LEDBrightness > 1023) LEDBrightness = 0;
  //setVib1Strength(900);
  //waitFor(100);
  
  //userLED_OFF();
  //setVib1Strength(0);
  //waitFor(100);
  //iterations++;
  
  //lcd.clear();
  //lcd.home();
  //lcd.print(iterations);
}

void updateSystem(){
  if(refreshSerial())packetsReceived++;
  //haptic1.update();
  //haptic2.update();
  buttonState = checkSwitch();
  updateBeep();
  if(buttonState) userLED_ON();
  else  userLED_OFF();
  
}

void waitFor(unsigned long delayTime){
  elapsedMillis delayTimer;
  while(delayTimer < delayTime) updateSystem();
}

void startTrial(){
  hapticRate1 = 0;
  hapticRate2 = 0;
  dataSendTimer = 0;
  setHaptics();
  startTrackerball();
  beep(500);
  printMessage();
}

void stopTrial(){
  //stopTrackerball();
  beep(500);
  printMessage();
  hapticRate1 = 0;
  hapticRate2 = 0;
  setHaptics();
  dataSendTimer = 0;
}

void vibration1On(){
  digitalWrite(H1ENABLE, 1);
  digitalWrite(H1PWMPIN, 1);
}
void vibration1Off(){
  digitalWrite(H1ENABLE, 0);
  digitalWrite(H1PWMPIN, 0);
}

void vibration2On(){
  digitalWrite(H2ENABLE, 1);
  digitalWrite(H2PWMPIN, 1);
}
void vibration2Off(){
  digitalWrite(H2ENABLE, 0);
  digitalWrite(H2PWMPIN, 0);
}

void setVib1Strength(int intensity){
  if(intensity > 0){
    vibration1On();
    analogWrite(H1PWMPIN, intensity);
  }
  else {
    vibration1Off();
    analogWrite(H1PWMPIN, 0);
  }
}

void setVib2Strength(int intensity){
  if(intensity > 0){
    vibration2On();
    analogWrite(H2PWMPIN, intensity);
  }
  else {
    vibration2Off();
    analogWrite(H2PWMPIN, 0);
  }
}
void setHaptics(){
  
  setVib1Strength(hapticRate1);
  setVib2Strength(hapticRate2);
  //haptic1.setLra(hapticRate1);
  //haptic2.setLra(hapticRate2);
}

