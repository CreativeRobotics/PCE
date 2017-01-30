//all global variables


boolean dataLogActiveA = false;
boolean surpressSerialA = false;
boolean serialAConnected = false;
int serialABytesRecieved = 0;
boolean dataLogActiveB = false;
boolean surpressSerialB = false;
boolean serialBConnected = false;
int serialBBytesRecieved = 0;
PrintWriter userALogFile;
PrintWriter userBLogFile;

color buttonNormal             = color(128); //mid grey
color buttonMouseover          = color(200); //light grey
color buttonActive             = color(128,0,0); //mid red
color buttonActiveMouseover    = color(200,0,0); //bright red


PrintWriter LogFileA;
boolean logAOpen = false;
PrintWriter LogFileB;
boolean logBOpen = false;


PFont myFont;

ControlP5 cp5;

Textlabel serialTextA;
String[] portList; //the list of available serial ports
int portAIndex = 0;
int serialBytesRecievedA  =0;
Textlabel serialTextB;
int portBIndex = 0;
int serialBytesRecievedB  =0;

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

boolean userATouchingStatic = false; //set to true of the user is touching something that should sethe haptic feedbac off
boolean userBTouchingStatic = false;
boolean userATouchingLure = false;
boolean userBTouchingLure = false;
boolean bothUsersTouching = false; //if both users are touching each other