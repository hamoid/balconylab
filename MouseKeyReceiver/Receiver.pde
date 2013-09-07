import oscP5.*;
import netP5.*;

class Receiver {
  OscP5 oscP5;

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
  }
  
  void setMouseData(float x, float y, boolean pressed) {
    mouseData[mouseDataWritePointer] = new MouseData(x, y, pressed);
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
  
  void setKeyData(char k) {
    keyData[keyDataWritePointer] = new KeyData(k);
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
      float x = msg.get(0).floatValue();  
      float y = msg.get(1).floatValue();
      boolean p = msg.get(2).intValue() == 1;
      rec.setMouseData(x, y, p);
    } else if (msg.checkAddrPattern("/keyPressed")) {
      char k = msg.get(0).charValue();
      rec.setKeyData(k);
    }
  }
}
// simple object to store received mouse event details
class MouseData {
  float x;
  float y;
  boolean pressed;
  MouseData(float x, float y, boolean pressed) {
    this.x = x;
    this.y = y;
    this.pressed = pressed;
  }
}
// simple object to store received key press event details
class KeyData {
  char key;
  KeyData(char key) {
    this.key = key;
  }
}

