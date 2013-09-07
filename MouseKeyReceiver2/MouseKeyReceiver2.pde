Receiver rec;

// http://bit.ly/p2pp5
// http://tinyurl.com/P5JamSep2013

//   ____  ____  ___  ____  ____  _  _  ____  ____ 
//  (  _ \( ___)/ __)( ___)(_  _)( \/ )( ___)(  _ \
//   )   / )__)( (__  )__)  _)(_  \  /  )__)  )   /
//  (_)\_)(____)\___)(____)(____)  \/  (____)(_)\_)

// You can run this program together with 
// MouseKeySender or MouseKeyTestSender

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  colorMode(HSB);
  noFill();
  rec = new Receiver(12000);
}
void draw() {
  // Loop through all users who are sending data
  // Each user has: 
  // .id       int      0 .. 255 user ID (taken from last IP digit)
  // .x        float    0 .. 1 horizontal position of the mouse
  // .y        float    0 .. 1 vertical position of the mouse
  // .pressed  boolean  Is the mouse down?
  // .key      char     Last key pressed in the keyboard
  
  for (UserData user : rec.userData.values()) {
    fill(user.id * 100 % 255, 200, 200, 100);
    textSize(user.pressed ? 30 : 20);
    text(user.key, user.x*width, user.y*height);
  }
}

