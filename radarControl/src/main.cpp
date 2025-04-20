#include <Arduino.h>
#include "Servo.h"

Servo myServo;
int distance = 0;

void sweepServo(int start, int stop, int step){
  for (int pos = start; pos != stop; pos += step) { // Sweep from 180 to 0 degrees
    myServo.write(pos); // Set the servo position
    delay(15); // Wait for the servo to reach the position
    Serial.print(pos);
    Serial.print(",");
    Serial.print(distance);
    Serial.print(".");
  }
}

void setup() {
  Serial.begin(9600);
  myServo.attach(3); // Attach the servo on pin 3
}

void loop() {
  sweepServo(0, 180, 1);
  sweepServo(180, 0, -1);
}

