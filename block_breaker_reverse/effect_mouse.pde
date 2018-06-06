class Effect_mouse {//マウスクリック時のマウスカーソル周辺へのエフェクト
  float x[] = new float[6];
  float y[] = new float[4];
  Effect_mouse() {
    for (int n = 0; n < y.length; n++) {
      y[n] = n * PI / 2;
    }
  }
  void display() {
    fill(255);
    stroke(255, 0, 0);
    strokeWeight(1);
    ellipse(mouseX, mouseY, 20, 20);
    fill(255);
    stroke(255, 0, 0);
    strokeWeight(1);
    ellipse(mouseX, mouseY, 27, 27);
    for (int m = 0; m < y.length; m++) {
      y[m] +=PI/60;
      fill(255);
      noStroke();
      ellipse(mouseX+ 25 * cos(y[m]), mouseY + 25 * sin(y[m]), 10, 10);
    }
    for (int m = 0; m < y.length; m++) {
      y[m] +=PI/60;
      fill(255, 100, 0);
      stroke(255, 0, 0);
      strokeWeight(1);
      line(mouseX, mouseY, mouseX + 25 * cos(y[m]), mouseY + 25 * sin(y[m]));
    }
  }
}
