void gametitle() {//タイトル画面

  textSize(60);
  background(255);
  fill(0);
  text("Block breaker reverse", width / 2 - 320, 350);
  textSize(40);
  text("press 's' to start", width / 2 - 160, 420);
  textSize(20);
  text("press 'd' to move right", 50, 500); 
  text("press 'a' to move right", 50, 530); 
  text("click 'mouse' to generate acceleration to mouse cursor", 50, 560);
  if (keyPressed) {
    if (key == 's') {
      timer_title = millis();
      state += 1;
    }
  }
}
