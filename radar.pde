import processing.serial.*; // imports library for serial communication
import java.awt.event.KeyEvent; // imports library for reading the data from the serial port
import java.io.IOException;
Serial myPort;
String angle="";
String distance="";
String data="";
String noObject;
float pixsDistance;
int iAngle, iDistance;
int index1=0;
int index2=0;
PFont myFont;

void setup() {
  
 size (1366, 768);
 smooth();
 myPort = new Serial(this,"COM6", 9600); // starts the serial communication
 myPort.bufferUntil('.'); // reads the data from the serial port up to the character '.'. So actually it reads this: angle,distance.
 myFont = createFont("Courier", 32);
 textFont(myFont);
 textAlign(CENTER, CENTER);
 //text("!@#$%", width/2, height/2);

}


void draw() {
  
  fill(98,245,31);
  textFont(myFont);
  // simulating motion blur and slow fade of the moving line
  noStroke();
  fill(0,4); 
  rect(0, 0, width, 1010); 
  
  fill(98,245,31); // green color
  // calls the functions for drawing the radar
  drawRadar(); 
  drawLine();
  drawObject();
  drawText();
  //text("!@#$%", width/2, height/2);
}

void serialEvent (Serial myPort) { // starts reading data from the Serial Port
  // reads the data from the Serial Port up to the character '.' and puts it into the String variable "data".
  data = myPort.readStringUntil('.');
  data = data.substring(0,data.length()-1);
  
  index1 = data.indexOf(","); // find the character ',' and puts it into the variable "index1"
  angle= data.substring(0, index1); // read the data from position "0" to position of the variable index1 or thats the value of the angle the Arduino Board sent into the Serial Port
  distance= data.substring(index1+1, data.length()); // read the data from position "index1" to the end of the data pr thats the value of the distance
  
  // converts the String variables into Integer
  iAngle = int(angle);
  iDistance = int(distance);
}

void drawRadar() {
  pushMatrix();
  translate(675,625); // moves the starting coordinats to new location
  noFill();
  strokeWeight(2);
  stroke(98,245,31);
  // draws the arc lines
  //arc(0,0,1200,1200,PI,TWO_PI);
  arc(0,0,1000,1000,PI,TWO_PI);
  arc(0,0,800,800,PI,TWO_PI);
  arc(0,0,600,600,PI,TWO_PI);
  arc(0,0,400,400,PI,TWO_PI);
  
  // draws the angle lines
  line(-480,0,480,0);
  line(0,0,-600*cos(radians(30)),-600*sin(radians(30)));
  line(0,0,-600*cos(radians(60)),-600*sin(radians(60)));
  line(0,0,-600*cos(radians(90)),-600*sin(radians(90)));
  line(0,0,-600*cos(radians(120)),-600*sin(radians(120)));
  line(0,0,-600*cos(radians(150)),-600*sin(radians(150)));
  line(-960*cos(radians(30)),0,960,0);
  popMatrix();
}

void drawObject() {
  pushMatrix();
  translate(675,625); // moves the starting coordinats to new location
  strokeWeight(9);
  stroke(255,10,10); // red color
  pixsDistance = iDistance*12.5; // covers the distance from the sensor from cm to pixels
  // limiting the range to 40 cms
  if(iDistance<40){
    // draws the object according to the angle and the distance
  line(pixsDistance*cos(radians(iAngle)),-pixsDistance*sin(radians(iAngle)),600*cos(radians(iAngle)),-600*sin(radians(iAngle)));
  }
  popMatrix();
}

void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30,250,60);
  translate(675,625); // moves the starting coordinats to new location
  line(0,0,600*cos(radians(iAngle)),-600*sin(radians(iAngle))); // draws the line according to the angle
  popMatrix();
}

void drawText() { // draws the texts on the screen
  
  pushMatrix();
  if(iDistance>40) {
  noObject = "Out of Range";
  }
  else {
  noObject = "In Range";
  }
  fill(0,0,0);
  noStroke();
  rect(0, 1010, width, 1080);
  fill(98,245,31);
  textSize(25);
  text("15cm",840,600);
  text("23cm",945,600);
  text("31cm",1040,600);
  text("40cm",1140,600);
  //text("40cm",1230,600);
  textSize(40);
  text("Object:   ", 170, 650);
  text(noObject,360,650);
  text("Angle:   " , 625, 650);
  text(iAngle,700,650);
  text("Distance: ", 970, 650);
  if(iDistance<40) {
  text("        " + iDistance +" cm", 1120, 650);
  }
  textSize(25);
  fill(98,245,60);
  translate(1230+cos(radians(30)),330+sin(radians(30)));
  rotate(-radians(-60));
  text("30°",0,0);
  resetMatrix();
  translate(990+cos(radians(60)),95+sin(radians(60)));
  rotate(-radians(-30));
  text("60°",0,0);
  resetMatrix();
  translate(675+cos(radians(90)),7+sin(radians(90)));
  rotate(radians(0));
  text("90°",0,0);
  resetMatrix();
  translate(850+960*cos(radians(120)),90+sin(radians(120)));
  rotate(radians(-30));
  text("120°",0,0);
  resetMatrix();
  translate(970+960*cos(radians(150)),625*sin(radians(150)));
  rotate(radians(-60));
  text("150°",0,0);
  popMatrix(); 
}
