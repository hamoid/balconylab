import oscP5.*;
import netP5.*;
import java.util.Map;

class Receiver {
  OscP5 oscP5;
  
  HashMap<Integer,UserData> userData;

  int ARRAY_LENGTH = 2000;

  int mouseDataReadPointer = 0;  
  int mouseDataWritePointer = 0;  
  MouseData[] mouseData;

  int keyDataReadPointer = 0;
  int keyDataWritePointer = 0;
  KeyData[] keyData;

  Receiver(int port) {
    oscP5 = new OscP5(this, port);
    mouseData = new MouseData[ARRAY_LENGTH];
    keyData = new KeyData[ARRAY_LENGTH];
    userData = new HashMap<Integer,UserData>();
  }
  
  void setMouseData(int usrid, float x, float y, boolean pressed) {
    UserData u = userData.get(usrid);
    if(u == null) {
      userData.put(usrid, new UserData(usrid, x, y, pressed, ' '));
    } else {
      u.setMouse(x, y, pressed);
    }
    mouseData[mouseDataWritePointer] = new MouseData(usrid, x, y, pressed);
    mouseDataWritePointer = (mouseDataWritePointer + 1) % ARRAY_LENGTH;
  }
  MouseData getMouseData() {
    if (mouseDataReadPointer == mouseDataWritePointer) {
      return null;
    }
    MouseData result = mouseData[mouseDataReadPointer];
    if (result != null) {
      mouseDataReadPointer = (mouseDataReadPointer + 1) % ARRAY_LENGTH;
    }
    return result;
  }
  
  void setKeyData(int usrid, char k) {
    UserData u = userData.get(usrid);
    if(u == null) {
      userData.put(usrid, new UserData(usrid, 0, 0, false, k));
    } else {
      u.setKey(k);
    }
    keyData[keyDataWritePointer] = new KeyData(usrid, k);
    keyDataWritePointer = (keyDataWritePointer + 1) % ARRAY_LENGTH;
  }
  KeyData getKeyData() {
    if (keyDataReadPointer == keyDataWritePointer) {
      return null;
    }
    KeyData result = keyData[keyDataReadPointer];
    if (result != null) {
      keyDataReadPointer = (keyDataReadPointer + 1) % ARRAY_LENGTH;
    }
    return result;
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
// simple object to store received mouse event details
class MouseData {
  int usrid;
  float x;
  float y;
  boolean pressed;
  MouseData(int usrid, float x, float y, boolean pressed) {
    this.usrid = usrid;
    this.x = x;
    this.y = y;
    this.pressed = pressed;
  }
}
// simple object to store received key press event details
class KeyData {
  int usrid;
  char key;
  KeyData(int usrid, char key) {
    this.usrid = usrid;
    this.key = key;
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

