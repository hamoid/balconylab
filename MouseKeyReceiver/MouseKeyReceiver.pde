Receiver rec;

/*
 ____  ____  ___  ____  ____  _  _  ____  ____ 
(  _ \( ___)/ __)( ___)(_  _)( \/ )( ___)(  _ \
 )   / )__)( (__  )__)  _)(_  \  /  )__)  )   /
(_)\_)(____)\___)(____)(____)  \/  (____)(_)\_)
*/

void setup() {
  size(600, 600);
  background(0);
  rec = new Receiver(12000);
}
void draw() {
  while(true) {
    // loop through all received mouse data 
    MouseData event = rec.getMouseData();
    // get out if no more data
    if(event == null) {
      break;
    }
    // MOUSE EVENT DRAW BEGIN
    // Use: event.x, event.y, event.pressed
    if(event.pressed) {
      stroke(255);
    } else {
      stroke(255, 10);
    }
    noFill();
    ellipse(event.x*width, event.y*height, 10, 10);
    // MOUSE EVENT DRAW END
  }
  
  while(true) {
    // loop through all received key data
    KeyData event = rec.getKeyData();
    // get out if no more data
    if(event == null) {
      break;
    }
    
    // KEY EVENT DRAW BEGIN
    // Use: keyData.key
    text(event.key, random(width), random(height));
    // KEY EVENT DRAW END
    
  }
}

