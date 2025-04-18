void drawBackgroundAndUI() {
  // 1) pozadina
  background(30, 30, 30);
  
  // 2) crna traka dole
  fill(0);
  noStroke();
  rect(0, height - 70, width, 70);
  
  // 3) separator linija
  stroke(0, 255, 0);
  strokeWeight(2);
  line(0, height - 70, width, height - 70);
  
  // 4) tekstualne etikete
  String s1 = "Object:";
  String s2 = "Angle:";
  String s3 = "Distance:";
  String name = "radov1c";
  
  // siva boja i veći font
  fill(150);
  textSize(30);
  textAlign(LEFT);
  
  // region širine 660px centriran po x-osi
  float regionW = 960;
  float startX  = (width - regionW) / 2;
  float step    = regionW / 3;
  float textY   = height - 35;
  
  text(s1, startX, textY);
  text(s2, startX + step * 1.4, textY);
  text(s3, startX + 2.5 * step, textY);
  
  textSize(20);
  textAlign(LEFT);
  float padding = 10;
  
  // Izračunavanje širine teksta da bi okvir bio tačne veličine
  float textW = textWidth(name);
  float textH = textAscent() + textDescent();
  
  // Pozicija okvira
  float boxX = 20;
  float boxY = textY;
  
  // Boja pozadine boxa
  fill(20, 40, 90);  // tamno plava
  noStroke();
  rect(boxX - padding, boxY - padding, textW + 2 * padding, textH + 2 * padding, 10); // zaobljeni ivice
  
  // Boja teksta
  fill(135, 206, 250);  // svetlo plava
  text(name, boxX, boxY + textH / 2);
  
  // 5) reset stila za crtanje radara
  noFill();
  stroke(0, 255, 0);
  strokeWeight(4);
}

void drawRadar(){
  
  drawBackgroundAndUI();

  float centerX = width / 2;
  float centerY = height - 70;
  
  int numArcs = 4;
  float maxWidth = width - 70;
  float maxHeight = height * 2 - 250;
  
  for (int r = 1; r <= numArcs; r++) {
      float factor = r / float(numArcs);
      float w = maxWidth * factor;
      float h = maxHeight * factor;
      arc(centerX, centerY, w, h, PI, TWO_PI);
  }
  
  // Poluprečnici spoljneg luka
  float outerRadiusX = maxWidth / 2;
  float outerRadiusY = maxHeight / 2;
  float scale = 1.04; // 4% produženje van elipse
  float textOffset = 1.02;  // 10% dalje od linije (za tekst)

  int numLines = 5;  // Broj linija (150°, 120°, 90°, 60°, 30°)
  float step = radians(30);  // 30 stepeni
  
  textSize(16);
  fill(0, 255, 0);  // Zelena boja za tekst
  textAlign(CENTER, CENTER);
  
  for (int i = 1; i <= numLines; i++) {
    // Ugao od 150° do 30° u opadajućem redosledu
    float angle = PI + i * step;  // 150°, 120°, 90°, 60°, 30°
    
    // Kordinate kraja linije
    float x = centerX + cos(angle) * outerRadiusX * scale;
    float y = centerY + sin(angle) * outerRadiusY * scale;
  
    // Iscrtavanje linije
    stroke(0, 255, 0);  // Zelena boja
    strokeWeight(2);
    line(centerX, centerY, x, y);
  
    // Tekst iznad linije (ugao)
    int angleDeg = 180 - i * 30;  // 150°, 120°, 90°, 60°, 30°
    float textX = centerX + cos(angle) * outerRadiusX * scale * textOffset;
    float textY = centerY + sin(angle) * outerRadiusY * scale * textOffset;
  
    // Postavljanje rotacije za pravi ugao
    pushMatrix();
    translate(textX, textY);
    rotate(angle + HALF_PI);  // Rotiraj tekst za 90 stepeni od linije
    text(angleDeg + "°", 0, 0);  // Nacrtaj tekst
    popMatrix();
  }
}
void setup() {
  size(1280, 680);
}

void draw() {

  // calls the functions for drawing the radar
  drawRadar();
}
