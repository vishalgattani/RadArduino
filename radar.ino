#include <Servo.h>
#include <LiquidCrystal.h>


const int trigPin = 9;
const int echoPin = 10;

long duration;
int distance;


LiquidCrystal lcd(12, 11, 5, 4, 3, 2);
Servo myServo;
void setup() {
  Serial.begin(9600);
  // put your setup code here, to run once:
  pinMode(trigPin, OUTPUT); // Sets the trigPin as an Output
  pinMode(echoPin, INPUT); // Sets the echoPin as an Input
  myServo.attach(13);
  lcd.begin(20,4);
  lcd.setCursor(5,0);
  lcd.print("RadARDUINO");
}

void loop() {
  // put your main code here, to run repeatedly:
// rotates the servo motor from 15 to 165 degrees
  int i=0;
  //lcd.setCursor(0,1);
  lcd.display();
 
  for(int i=1;i<180;i++){  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();// Calls a function for calculating the distance measured by the Ultrasonic sensor for each degree
  //lcd.print(i);
  //delay(50);
  //lcd.clear();
  lcd.setCursor(0,1);
  lcd.print("Angle:       Degrees");
  lcd.setCursor(6, 1);
  lcd.print(i);
  
  lcd.setCursor(0,2);
  lcd.print("Distance:   cm      ");
  lcd.setCursor(9,2);
  if(distance<40){
  lcd.print(distance);
  }
  else{
  lcd.print("OutOfRange");
  //lcd.clear();
  }
  delay(50);
  Serial.print(i); // Sends the current degree into the Serial Port
  Serial.print(","); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
  Serial.print(distance); // Sends the distance value into the Serial Port
  Serial.print("."); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
  }

  for(int i=179;i>0;i--){  
  myServo.write(i);
  delay(30);
  distance = calculateDistance();// Calls a function for calculating the distance measured by the Ultrasonic sensor for each degree
  //lcd.print(i);
  //delay(50);
  //lcd.clear();
  //lcd.setCursor(0,1);
  //lcd.print("Angle:         ");
  lcd.setCursor(0,1);
  lcd.print("Angle:       Degrees");
  lcd.setCursor(6, 1);
  lcd.print(i);
  
  lcd.setCursor(0,2);
  lcd.print("Distance:   cm      ");
  lcd.setCursor(9,2);
  if(distance<40){
  lcd.print(distance);
  }
  else{
  lcd.print("OutOfRange");
  //lcd.clear();
  }
  delay(50);
  Serial.print(i); // Sends the current degree into the Serial Port
  Serial.print(","); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
  Serial.print(distance); // Sends the distance value into the Serial Port
  Serial.print("."); // Sends addition character right next to the previous value needed later in the Processing IDE for indexing
  }
   
}

int calculateDistance(){ 
  
  digitalWrite(trigPin, LOW); 
  delayMicroseconds(2);
  // Sets the trigPin on HIGH state for 10 micro seconds
  digitalWrite(trigPin, HIGH); 
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH); // Reads the echoPin, returns the sound wave travel time in microseconds
  distance= duration*0.034/2;
  return distance;
}
