//driver for switch and LED

boolean checkSwitch(){
  //Switch input is active LOW
  return !digitalRead(USER_SWITCH_PIN);
}

void setUserLED(int ledVal){
  //assume a 10 bit PWM range ... because of the haptics library
  analogWrite(USER_LED_PIN, ledVal);
}

void userLED_ON(){
  analogWrite(USER_LED_PIN, 1023);
  //digitalWrite(USER_LED_PIN, 1);
  LEDBrightness = 1023;
}

void userLED_OFF(){
  analogWrite(USER_LED_PIN, 0);
  
  //digitalWrite(USER_LED_PIN, 0);
  LEDBrightness = 0;
}

void flash(unsigned long duration){
	userLED_ON();
	flashActive = 1;
	flashStart = millis();
  flashEnd = flashStart+ duration;
}

void updateFlash(){
  if(millis() > flashEnd){
		userLED_OFF();
		flashActive = 0;
	}
}