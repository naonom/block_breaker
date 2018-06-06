class Boost {//マウスがクリックされた点の向きに加速度ベクトルを追加
  PVector force_mouse;
  Boost() {
    force_mouse = new PVector(0, 0);
  }

  void update() {
    force_mouse.x = mouseX - location.x;
    force_mouse.y = mouseY - location.y;
    force_mouse.normalize();
    force_mouse.mult(5);
    force_all.add(force_mouse);
  }
}
