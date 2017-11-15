
int trialLengthSeconds = 10; //the length of the trial in seconds
int trialResolution = 100; //The number of updates per second - the maximum is approximatly 500
int messageFrequency = 100; //how many steps before updating the users screen message - If trialResolution is 100 steps per second then setting messageFrequency to 100 will update the screen once per second

long trialLengthMillis = trialLengthSeconds*1000;
//timing in seconds for the start beep/flash
//The middle beep/flash 
//the end beep flash

//ALL ARE IN MILLISECONDS
long startindicatorLength = 500;
boolean startIndicatorOn = false;

long middleIndicatorTime = 5000;
long middleIndicatorLength = 500;
boolean middleIndicatorOn = false;
boolean middleIndicatorDone = false;

long endIndicatorLength = 500;

//int trialState = 0;