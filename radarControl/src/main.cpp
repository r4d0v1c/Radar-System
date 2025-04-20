#include <Arduino.h>
#include "Servo.h"

Servo myServo;

void setup() {
  Serial.begin(9600);
  myServo.attach(3); // Attach the servo on pin 3
}

void loop() {
  for (int pos = 0; pos <= 180; pos += 1) { // Sweep from 0 to 180 degrees
    myServo.write(pos); // Set the servo position
    delay(15); // Wait for the servo to reach the position
    Serial.print(pos);
  }
  for (int pos = 180; pos >= 0; pos -= 1) { // Sweep from 180 to 0 degrees
    myServo.write(pos); // Set the servo position
    delay(15); // Wait for the servo to reach the position
    Serial.print(pos);
  }
}
