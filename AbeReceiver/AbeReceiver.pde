Receiver rec;

// http://bit.ly/p2pp5

//   ____  ____  ___  ____  ____  _  _  ____  ____ 
//  (  _ \( ___)/ __)( ___)(_  _)( \/ )( ___)(  _ \
//   )   / )__)( (__  )__)  _)(_  \  /  )__)  )   /
//  (_)\_)(____)\___)(____)(____)  \/  (____)(_)\_)

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  colorMode(HSB);
  noFill();
  rec = new Receiver(12000);
}
void draw() {
  // Add all keys together
  int totalKey = 0;
  for (UserData user : rec.userData.values()) {
    totalKey += int(user.key);
  }

  // draw shape
  noFill();
  stroke(totalKey % 255, 200, 200, 100);
  beginShape();
  for (UserData user : rec.userData.values()) {
    vertex(user.x*width, user.y*height);
  }
  endShape();  

  // drawe circle if pressed
  for (UserData user : rec.userData.values()) {
    if (user.pressed) {
      fill(0, 20);
      noStroke();
      ellipse(user.x*width, user.y*height, 30, 30);
    }
  }
}

