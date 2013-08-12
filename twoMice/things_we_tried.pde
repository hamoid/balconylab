/*
  // Conclusions
  
  1. We are not able to send the pixels array
  as a byte[] blob. There is either a limit
  in the size of osc messages or a bug.
  
  2. We can send many integers in an osc message,
  but the limit seems to be 305, not more (tested
  on a Windows machine).
  
  3. To send the whole screen we have to send arrays
  of up to 305 pixels (probably less if we want to
  indicade which pixels we are sending).

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
void sendRandomPixels() {
  OscMessage msg = new OscMessage("/pixels");
  loadPixels();
  for (int i=0; i < 150; i++) {
    int loc = (int) random(img.pixels.length);
    msg.add(loc);
    msg.add(pixels[loc]);
  }
  oscP5.send(msg, theOther);
}
*/
