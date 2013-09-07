import oscP5.*;
import netP5.*;

PVector lastPointByOther;

OscP5 oscP5;
NetAddress theOther;

void setup() {
  background(255);
  noStroke();
  size(800, 600);
  frameRate(25);

  oscP5 = new OscP5(this, MY_PORT);
  theOther = new NetAddress(OTHER_IP, OTHER_PORT);
}

void draw() {
  if (mousePressed) {
    // send my mouse position to the other
    OscMessage msg = new OscMessage("/mousePosition");
    msg.add(mouseX);
    msg.add(mouseY);
    oscP5.send(msg, theOther);
    
    // draw my own mouse
    stroke(#27FF72);
    line(mouseX, mouseY, pmouseX, pmouseY);
  }  
}

// I received a message!
void oscEvent(OscMessage msg) {
  if (msg.checkAddrPattern("/mousePosition")) {
    int x = msg.get(0).intValue();  
    int y = msg.get(1).intValue();
    
    // draw mouse sent by the other
    stroke(#FF0572);
    if (lastPointByOther != null) {
      line(x, y, lastPointByOther.x, lastPointByOther.y);
    }
    lastPointByOther = new PVector(x, y);
  }
}

