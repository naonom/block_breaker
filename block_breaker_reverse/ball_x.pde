boolean right, left;//'a''d'が押されたとき速度ベクトルの追加

void keyPressed() {
  if (key == 'd') right = true;
  if (key == 'a') left = true;
}

void keyReleased() {
  if (key == 'd') right = false;
  if (key == 'a') left = false;
}
