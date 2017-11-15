//all global variables
boolean MOUSE_TEST_MODE = false;
int practiceMode = 4; //free practice
boolean animateTrials = true;
/*Practice modes:
0 = no practice
1 = practice with static object
2 = practice with slow moving object
3 = practice with fast moving object
4 = free practice
*/
int practiceIterations = 0;
boolean debugPrintA = false;
boolean debugPrintB = false;
boolean debugGeneral = false;
boolean surpressSerialA = false;
boolean serialAConnected = false;
int serialABytesRecieved = 0;
boolean surpressSerialB = false;
boolean serialBConnected = false;
int serialBBytesRecieved = 0;

//Time benchmarking variables for measuring latencies on the trial loop
boolean logBenchmarks = false;
long loopStartMark = 0;
long loopMark1 = 0;
long loopMark2 = 0;
long loopMark3 = 0;
long loopMark4 = 0;
long loopEndMark = 0;
long endOfThisStep = 0;

//Timing for the trial
long trialStartTime;
//These are all set when the applications runs.
int numberOfIterations = 100;
long millisecondsBetweenSteps = 10;
int trialStep = 0;
//int targetTimestep = 0;
long lastStepStart = 0;
long lastStepTime = 0;
boolean trialActive = false;

long incrimentalTime = 0;

long elapsedTrialTime =0;
long startTime = 0;
long endTime = 0;
long oldTime = 0;

boolean surpressA = false;
int systemFrameRate = 100;
boolean waitingForA = false;
boolean newDataFromA = false;
int errorCountA = 0;
int timeoutsA = 0;
long responseTimeA = 0;
long sentATime = 0;
boolean surpressB = true;
boolean waitingForB = false;
boolean newDataFromB = false;
int errorCountB = 0;
int timeoutsB = 0;
long responseTimeB = 0;
long sentBTime = 0;


PFont pfont;
ControlFont largeFont;

color buttonNormal             = color(128); //mid grey
color buttonMouseover          = color(200); //light grey
color buttonActive             = color(128,0,0); //mid red
color buttonActiveMouseover    = color(200,0,0); //bright red


PrintWriter LogFileA;
boolean logAOpen = false;
PrintWriter LogFileB;
boolean logBOpen = false;
PrintWriter LogFileCombined;
boolean logCombinedOpen = false;


PFont myFont;

ControlP5 cp5;

Textlabel serialTextA;
String[] portList; //the list of available serial ports
int portAIndex = 0;
int serialALinesReceived  =0;
Textlabel serialTextB;
int portBIndex = 0;
int serialBLinesReceived  =0;

String portA;
String portB;

static char LINEFEED = 10;
static char NEWLINE = 10;
static char CARRAIGERETURN = 13;
Serial myPortA;      // The serial port
Serial myPortB;      // The serial port


//Controls

int listBoxWidth = 200;
int listBoxHeight = 100;

int startAX = 10;
int startBX = 10; //initialised with window width in startup
int startAY = 10;
int startBY = 10;

//virtual environment
int userAHue = 0;
int userBHue = 128;
int userBrightness = 255;
int lureBrightness = 180;
int staticBrightness = 120;
int userAPos = 100;
int userBPos = 400;
int envWidth = 600;
int envStart = 100; //how far from the screen edge
int envYPos = 300;
int envHeight = 50;

int movingObjectPosA = 100;
int movingObjectPosB = 100;
int slowSpeed = 1; //speed of moving object for practice 2 (Pixels per timestep)
int fastSpeed = 3; //speed of moving object for practice 3
boolean userATouchingStatic = false; //set to true of the user is touching something that should sethe haptic feedbac off
boolean userBTouchingStatic = false;
boolean userATouchingLure = false;
boolean userBTouchingLure = false;
boolean bothUsersTouching = false; //if both users are touching each other

boolean userAContact = false; //true for any valid contact
boolean userBContact = false;