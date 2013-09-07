import oscP5.*;
import netP5.*;

//  ___  ____  _  _  ____  ____  ____ 
// / __)( ___)( \( )(  _ \( ___)(  _ \
// \__ \ )__)  )  (  )(_) ))__)  )   /
// (___/(____)(_)\_)(____/(____)(_)\_)

// NOTE: Ask the receiver for his IP address and PORT!

String OTHER_IP = "127.0.0.1";
int MY_ID = 0;
int OTHER_PORT = 12000;


OscP5 oscP5;
NetAddress theOther;

void setup() {
  size(600, 600);
  frameRate(25);
  background(0);

  MY_ID = findMyID();
  
  // myself
  oscP5 = new OscP5(this, OTHER_PORT+1);
  // other
  theOther = new NetAddress(OTHER_IP, OTHER_PORT);
}

void draw() {
}
void mouseMoved() {
  sendMouse();
}
void mouseDragged() {
  sendMouse();
  // draw locally for debugging
  stroke(255);
  line(mouseX, mouseY, pmouseX, pmouseY);
}
void sendMouse() {
  OscMessage msg = new OscMessage("/mouseMoved");
  msg.add(MY_ID);
  msg.add(mouseX/float(width));
  msg.add(mouseY/float(height));
  msg.add(mousePressed ? 1 : 0);
  oscP5.send(msg, theOther);  
}
void keyPressed() {
  OscMessage msg = new OscMessage("/keyPressed");
  msg.add(MY_ID);
  msg.add(key);
  oscP5.send(msg, theOther);
  
  // draw locally for debugging
  if (key != CODED) {
    noStroke();
    fill(0, 20);
    rect(0, height-120, width, 30);
    fill(255);
    text(key, frameCount % width, height - 100);
  }
}
//boolean sketchFullScreen() {
//  return true;
//}

