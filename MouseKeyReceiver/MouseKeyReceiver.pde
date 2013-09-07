Receiver rec;

// http://bit.ly/p2pp5

//   ____  ____  ___  ____  ____  _  _  ____  ____ 
//  (  _ \( ___)/ __)( ___)(_  _)( \/ )( ___)(  _ \
//   )   / )__)( (__  )__)  _)(_  \  /  )__)  )   /
//  (_)\_)(____)\___)(____)(____)  \/  (____)(_)\_)

void setup() {
  size(600, 600);
  background(0);
  colorMode(HSB);
  rec = new Receiver(12000);
}
void draw() {
  while (true) {
    // loop through all received mouse data 
    MouseData event = rec.getMouseData();
    // get out if no more data
    if (event == null) {
      break;
    }
    // MOUSE EVENT DRAW BEGIN
    // Use: event.usrid, event.x, event.y, event.pressed
    if (event.pressed) {
      // set a color based on the usr id (number between 0 and 255)
      // since most IDs will be sequential (44, 45, 46) I multiply my 100
      // and get the modulo to make the colors vary more
      stroke(event.usrid * 100 % 256, 255, 255);
    } 
    else {
      stroke(event.usrid * 100 % 256, 255, 255, 10);
    }
    noFill();

    ellipse(event.x*width, event.y*height, 10, 10);
    // MOUSE EVENT DRAW END
  }

  while (true) {
    // loop through all received key data
    KeyData event = rec.getKeyData();
    // get out if no more data
    if (event == null) {
      break;
    }

    // KEY EVENT DRAW BEGIN
    // Use: event.usrid, keyData.key

    // set a color based on the usr id (number between 0 and 255);
    fill(event.usrid * 100 % 256);

    noStroke();
    text(event.key, random(width), random(height));
    // KEY EVENT DRAW END
  }
}

