/*
  ...OscEvent
  if (msg.checkAddrPattern("/screen")) {
    updateScreen(msg.get(0).intValue(), msg.get(1).bytesValue());
  }

void sendScreen() {
  loadPixels();
  OscMessage msg = new OscMessage("/screen");
  msg.add(pixels);
  oscP5.send(msg, theOther);
  println(pixels.length);
}
void sendLine() {
  int y = int(random(height));
  loadPixels();
  OscMessage msg = new OscMessage("/screen");
  byte[] mypixels = new byte[width*3];
  msg.add(y);
  for (int x=0; x<4; x++) {
    int p = pixels[y*width+x];
    mypixels[x*3] = byte(p & 0xFF);
    mypixels[x*3+1] = byte((p & 0xFF00) >> 8);
    mypixels[x*3+2] = byte((p & 0xFF0000) >> 16);
  }
  msg.add(mypixels);
  oscP5.send(msg, theOther);
}
void updateScreen(int line, byte[] screen) {
  loadPixels();
  int startPoint = line*width;
  for (int x = 0; x < screen.length;x+=3)
    pixels[startPoint+x/3] = color(screen[x], screen[x+1], screen[x+2]);
  // println(screen.length);
  updatePixels();
}
*/
