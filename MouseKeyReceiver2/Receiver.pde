import oscP5.*;
import netP5.*;
import java.util.Map;

class Receiver {
  OscP5 oscP5;
  
  HashMap<Integer,UserData> userData;

  Receiver(int port) {
    oscP5 = new OscP5(this, port);
    userData = new HashMap<Integer,UserData>();
  }
  
  void setMouseData(int usrid, float x, float y, boolean pressed) {
    UserData u = userData.get(usrid);
    if(u == null) {
      userData.put(usrid, new UserData(usrid, x, y, pressed, ' '));
    } else {
      u.setMouse(x, y, pressed);
    }
  }  
  void setKeyData(int usrid, char k) {
    UserData u = userData.get(usrid);
    if(u == null) {
      userData.put(usrid, new UserData(usrid, 0, 0, false, k));
    } else {
      u.setKey(k);
    }
  }

  // when we receive data from others
  void oscEvent(OscMessage msg) {
    if (msg.checkAddrPattern("/mouseMoved")) {
      int usrid = msg.get(0).intValue();
      float x = msg.get(1).floatValue();  
      float y = msg.get(2).floatValue();
      boolean p = msg.get(3).intValue() == 1;
      rec.setMouseData(usrid, x, y, p);
    } else if (msg.checkAddrPattern("/keyPressed")) {
      int usrid = msg.get(0).intValue();
      char k = msg.get(1).charValue();
      rec.setKeyData(usrid, k);
    }
  }
}
class UserData {
  int id;
  float x;
  float y;
  boolean pressed;
  char key;
  UserData(int id, float x, float y, boolean pressed, char key) {
    this.id = id;
    this.setMouse(x, y, pressed);
    this.setKey(key);
  }
  void setMouse(float x, float y, boolean pressed) {
    this.x = x;
    this.y = y;
    this.pressed = pressed;
  }
  void setKey(char key) {
    this.key = key;
  }
}

