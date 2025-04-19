import processing.serial.*;
import java.awt.event.KeyEvent; // imports library for reading the data from the serial port
import java.io.IOException;

int iAngle; //prima vrednost ugla
int distance;
int index1 = 0;
int index2 = 0;
float pixsDistance;
String angle = "";
String object = "";
String data = "";
String noObject;

Serial myPort;

void setup() {
  fullScreen(P2D);
  smooth();
  myPort = new Serial(this, "/dev/ttyACM0", 9600);
  myPort.bufferUntil('.'); // reads the data from the serial port up to the character '.'. So actually it reads this: angle,distance.
}

void draw() {
  fill(98, 245, 31);
  // simulating motion blur and slow fade of the moving line
  noStroke();
  fill(0, 4);
  rect(0, 0, width, height - height * 0.09); 

  fill(98, 245, 31); // green
  
  // calls the functions for drawing the radar
  drawRadar();
  
  // calls the functions for drawing the line
  drawLine();
  
  // cals the functions for drawing the object
  drawObject();
  
  // calls the functions for drawing the text
  drawText();
}

void drawRadar(){
  pushMatrix();
  translate(width / 2, height - height * 0.1); // moves the starting coordinates to new location
  noFill();
  strokeWeight(2);
  stroke(98, 245, 31);
  
  // draws the arc lines
  arc(0, 0, (width - width * 0.0625), (width - width * 0.0625), PI, TWO_PI);
  arc(0, 0, (width - width * 0.27), (width - width * 0.27), PI, TWO_PI);
  arc(0, 0, (width - width * 0.479), (width - width * 0.479), PI, TWO_PI);
  arc(0, 0, (width - width * 0.687), (width - width * 0.687), PI, TWO_PI);
  
  float scale = 0.97; // 0.97% produženje van elipse

  int numLines = 7;  // Broj linija (180°, 150°, 120°, 90°, 60°, 30°, 0°)
 
  for (int i = 0; i < numLines; i++) {
    // Kordinate kraja linije
    float x =(-width / 2) * cos(radians(30 * i)) * scale;
    float y = (-width / 2) * sin(radians(30 * i)) * scale;
  
    // Iscrtavanje linije
    stroke(0, 255, 0);  // Zelena boja
    strokeWeight(2);
    line(0, 0, x, y);
  }
 popMatrix();
}
void drawLine() {
  pushMatrix();
  strokeWeight(9);
  stroke(30, 250, 60);
  translate(width / 2, height - height * 0.099); // moves the starting coordinates to new location
  line(0, 0, (height - height * 0.12) * cos(radians(iAngle)), -(height - height * 0.12) * sin(radians(iAngle)));
  // draws the line according to the angle
  popMatrix();
}
void serialEvent(Serial myPort) { 
  // starts reading data from the Serial Port
  data = myPort.readStringUntil('.');
  data = data.substring(0, data.length() - 1);

  index1 = data.indexOf(","); // find the character ',' and puts it into the variable "index1"
  angle = data.substring(0, index1); // read the data from position "0" to position of the variable index1 or that's the value of the angle the Arduino Board sent into the Serial Port
  distance = Integer.parseInt(data.substring(index1 + 1)); // read the data from position "index1" to the end of the data which is the value of the distance
  
  // converts the String variables into Integer
  iAngle = int(angle);
  distance = int(distance);
}
void drawText(){
   pushMatrix();
   
   // if object is in range
   if(distance < 40)
     noObject = "In Range";
   else
     noObject = "Out of Range";
   
   fill(0);
   noStroke();
   rect(0, height - height * 0.0948, width, height);  // Black bar at the bottom
   
   fill(98, 245, 31); // Radar green color
   textSize(25);
   
   // Labels for distances
  text("10cm", width - width * 0.3714, height - height * 0.11);
  text("20cm", width - width * 0.267, height - height * 0.11);
  text("30cm", width - width * 0.163, height - height * 0.11);
  text("40cm", width - width * 0.0589, height - height * 0.11);
  
  textSize(40);
  
  // Display the user's name and angle and distance information
  text("Object: ", width - width * 0.875, height - height * 0.0277);
  text("Angle: " + iAngle + " °", width - width * 0.48, height - height * 0.0277);
  text("Distance: ", width - width * 0.26, height - height * 0.0277);
  
  if(distance < 40)
    text(distance + "cm", width - width * 0.14, height - height * 0.0277); 
    
  textSize(25);
  fill(98, 245, 60); // Green color for angles

  // Display angles and ensure the text is rotated correctly for each line
  translate((width - width * 0.4994) + width / 2 * cos(radians(30)), (height - height * 0.0907) - width / 2 * sin(radians(30)));
  rotate(radians(60));
  text("30°", 0, 0);
  resetMatrix();

  translate((width - width * 0.503) + width / 2 * cos(radians(60)), (height - height * 0.0888) - width / 2 * sin(radians(60)));
  rotate(radians(30));
  text("60°", 0, 0);
  resetMatrix();

  translate((width - width * 0.507) + width / 2 * cos(radians(90)), (height - height * 0.0833) - width / 2 * sin(radians(90)));
  rotate(radians(0));
  text("90°", 0, 0);
  resetMatrix();

  translate(width - width * 0.513 + width / 2 * cos(radians(120)), (height - height * 0.07129) - width / 2 * sin(radians(120)));
  rotate(radians(-30));
  text("120°", 0, 0);
  resetMatrix();

  translate((width - width * 0.5104) + width / 2 * cos(radians(150)), (height - height * 0.0574) - width / 2 * sin(radians(150)));
  rotate(radians(-60));
  text("150°", 0, 0);
  
  popMatrix();
}
void drawObject() {
  pushMatrix();
  translate(width / 2, height - height * 0.099); // moves the starting coordinates to new location
  strokeWeight(9);
  stroke(255, 10, 10); // red color
  
  pixsDistance = distance * ((height - height * 0.1666) * 0.025); // converts the distance from the sensor (cm) to pixels
  
  // limiting the range to 40
  if (distance < 40) {
    // draws the object according to the angle and distance
    line(pixsDistance * cos(radians(iAngle)), -pixsDistance * sin(radians(iAngle)), (width - width * 0.505) * cos(radians(iAngle)), -(width - width * 0.505) * sin(radians(iAngle)));
  }
  popMatrix();
}
