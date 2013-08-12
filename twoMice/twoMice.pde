import oscP5.*;
import netP5.*;

PVector lastPoint;

OscP5 oscP5;
NetAddress theOther;

void setup() {
  background(255);
  noStroke();
  size(800, 600);
  frameRate(25);
  oscP5 = new OscP5(this, MY_PORT);
  theOther = new NetAddress(OTHER_IP, OTHER_PORT);

  OscMessage msg = new OscMessage("/hello");
  msg.add("http://piratepad.net/pdmGz0lg9b");
  oscP5.send(msg, theOther);
/*
loadPixels();
for(int i=0; i < pixels.length;i++)
pixels[i] = color((int) random(255),(int) random(255),(int) random(255));
updatePixels();
*/
PImage img = loadImage("C:/Users/Ramin/Pictures/2 fretchen.jpg");
image(img,0,0,width,height);
}

void draw() {
  sendRandomPixels();
  if (mousePressed) {
    OscMessage msg = new OscMessage("/notatest");
    msg.add(mouseX);
    msg.add(mouseY);
    oscP5.send(msg, theOther);
    stroke(#27FF72);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }
  println(frameRate);
}
void mouseMoved() {
}
void keyPressed() {
  if (key == ' ') {
    background(255);
  }
  if (key == 's') {
    sendRandomPixels();
  }
}

void sendRandomPixels() {
  OscMessage msg = new OscMessage("/pixels");
  loadPixels();
  for (int i=0; i < 150; i++) {
    int loc = (int) random(pixels.length);
    msg.add(loc);
    msg.add(pixels[loc]);
  }
  oscP5.send(msg, theOther);
}

void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/hello")) {
    String a = msg.get(0).stringValue();
    println(a);
  }
  if (msg.checkAddrPattern("/notatest")) {
    int x = msg.get(0).intValue();  
    int y = msg.get(1).intValue();
    stroke(#FF0572);
    if (lastPoint != null) {
      line(x, y, lastPoint.x, lastPoint.y);
    }
    lastPoint = new PVector(x, y);
  }
  if (msg.checkAddrPattern("/pixels")) {
//      println(msg);
    loadPixels();
    for(int i=0; i<150; i++) {
      int which = msg.get(i*2).intValue();
      int val = msg.get(i*2+1).intValue();
      pixels[which] = val;
    }
    updatePixels();
  }
}

