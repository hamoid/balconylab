import oscP5.*;
import netP5.*;

/*
 ____  ____  ___  ____  ___  ____  _  _  ____  ____  ____ 
(_  _)( ___)/ __)(_  _)/ __)( ___)( \( )(  _ \( ___)(  _ \
  )(   )__) \__ \  )(  \__ \ )__)  )  (  )(_) ))__)  )   /
 (__) (____)(___/ (__) (___/(____)(_)\_)(____/(____)(_)\_)
 */

// NOTE: Ask the receiver for his IP address and PORT!

String OTHER_IP = "127.0.0.1";
int OTHER_PORT = 12000;

static int HOW_MANY_TEST_SENDERS = 5;

OscP5 oscP5;
NetAddress theOther;

void setup() {
  frameRate(25);
  background(0);

  // myself
  oscP5 = new OscP5(this, OTHER_PORT+1);
  // other
  theOther = new NetAddress(OTHER_IP, OTHER_PORT);

  text("FAKING", 20, 20);
}

void draw() {
  for (int i=1; i<=HOW_MANY_TEST_SENDERS; i++) {
    OscMessage msg = new OscMessage("/mouseMoved");
    msg.add(i);
    msg.add(noise(i, frameCount/float(20+i), 50));
    msg.add(noise(i, frameCount/float(20+i), 20));
    msg.add((frameCount/(100+i) % 2));
    oscP5.send(msg, theOther);
    
    if (frameCount % (20 + i) == 0) {
      msg = new OscMessage("/keyPressed");
      msg.add(i);
      msg.add(char(int(random(60, 100))));
      oscP5.send(msg, theOther);
    }
  }
}

