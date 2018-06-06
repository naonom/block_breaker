Boost b;
Effect_mouse e_mouse;
int r = 10;//ボール半径
PVector location;//ボール位置ベクトル
PVector velocity;//ボール速度ベクトル
PVector acceleration;//ボール加速度ベクトル
PVector force_gravity;//重力
PVector force_all;//力の合計
PVector effect_location;//ブロックエフェクト（未実装）
float mass = 50;//ボール質量
int data_x = 16;//ブロックの数（ｘ座標）
int data_y = 6;//ブロックの数（ｙ座標）
int i, j;
int [][] data_up = new int [data_x][data_y];//ブロック座標（上）
int [][] data_under = new int [data_x][data_y];//ブロック座標（下）
int [][] data_right = new int [data_x][data_y];//ブロック座標（右）
int [][] data_left = new int [data_x][data_y];//ブロック座標（左）
int [][] data_count = new int [data_x][data_y];//ブロックがあたり済みかどうか
int velocity_vector_x;//ボール速度ｘ成分
int velocity_vector_y;//ボール速度ｙ成分
int count_score;//スコアカウント

int state = 0;//画面切り替え用変数
int timer_title = 0;//タイトル画面滞在時間
int timer_play = 0;//プレイ時間



void setup() {
  size(800, 800);
  location = new PVector(width/2, 50);
  velocity = new PVector(0, 0);
  acceleration = new PVector(0, 0);
  force_gravity = new PVector(0, 1.5);
  force_all = new PVector(0, 0);
  effect_location = new PVector(data_up[i][j], data_left[i][j]);
  b = new Boost();
  e_mouse = new Effect_mouse();
  velocity_vector_x = 0;
  velocity_vector_y = 0;
  count_score = 0;
}

void draw() {//ゲーム画面を関数で制御
  if (state == 0) {
    gametitle();//タイトル画面
  } else if (state == 1) {
    gameplay();//ゲーム画面
  } else if (state == 2) {
    gamefinish();//終了画面
  }
}

void gameplay() {
  background(255);
  force_all.add(force_gravity);//力の合計に重力を加える

  if (mousePressed == true) {//マウスカーソルのエフェクト、加速度呼び出し
    b.update();
    e_mouse.display();
  }
  force_all.div(mass);//力の合計を位置ベクトルまで更新
  acceleration.add(force_all);
  velocity.add(acceleration);
  location.add(velocity);
  if (location.x <= 0 + r) {//壁左反射
    location.x = 0 + r;
    velocity.x = velocity.x * -0.5;
    acceleration.x *= 0;
  }
  if (location.x >= width - r) {//壁右反射
    location.x = width-r;
    velocity.x = velocity.x *= -1;
    acceleration.x *= 0;
  }
  if (location.y >= height - r ) {//壁下反射
    location.y = height - r;
    velocity.y = velocity.y * -1;
    acceleration.y *= 0;
  }
  if (location.y <= 0 + r) {//壁上反射
    location.y = 0 + r; 
    velocity.y = velocity.y * -1;
    acceleration.y *= 0;
  }
  if (right == true) { //十字キーによる速度ベクトルの変更
    velocity.x *= 0;
    location.x += 4;
  }
  if (left == true) {
    velocity.x *= 0;
    location.x -= 4;
  }
  fill(0, 0, 100, 30);//ボール表示
  stroke(0);
  strokeWeight(1);
  ellipseMode(RADIUS);
  ellipse(location.x, location.y, r, r);
  for (int i = 0; i < data_x; i=i+1) {//各ブロック内の変数を再更新
    for (int j = 0; j <data_y; j= j + 1) {
      if (data_count[i][j] != 1) {
        data_count [i][j] = 0;
      }
    }
  }
  for (int i = 0; i < data_x; i = i + 1) {//上下左右の当たり判定を各ブロックごとに算出
    for (int j = 0; j < data_y; j = j + 1) {
      if (data_count [i][j] == 0 ) {
        fill(255);//box color
        stroke(0);
        strokeWeight(2);
        rect(i * 50, j * 50 + 400, 50, 50);
        data_up [i][j] = j*50+400;
        data_under [i][j] = j*50+50+400;
        data_left [i][j] = i*50;
        data_right [i][j] = i*50+50;
        //count=0;
      }
    }
  }
  for (int i = 0; i < data_x; i = i + 1) {
    for (int j = 0; j < 6; j = j + 1) {
      if (pow(data_left[i][j] - location.x, 2) + pow(data_up[i][j] - location.y, 2) <= pow(r, 2) && data_count[i][j] == 0) {//左上当たり判定
        data_count[i][j] = 1;
        fill(0, 255, 0);
        stroke(0);
        rect(data_left[i][j], data_up[i][j], 50, 50);
        location.y = data_up[i][j] - (data_up[i][j] - location.y);
        location.x = data_left[i][j] - (data_left[i][j] - location.x);
        velocity_vector_y += 1;
        velocity_vector_x += 1;
        count_score += 1;
      }
      if (pow(data_right[i][j] - location.x, 2) + pow(data_up[i][j] - location.y, 2) <= pow(r, 2) && data_count[i][j] == 0) {//右上当たり判定
        data_count[i][j] = 1;
        fill(0, 255, 0);
        stroke(0);
        rect(data_left[i][j], data_up[i][j], 50, 50);
        velocity_vector_y += 1;
        velocity_vector_x += 1;
        count_score += 1;
      }
      if (pow(data_left[i][j] - location.x, 2) + pow(location.y - data_under[i][j], 2) <= pow(r, 2) && data_count[i][j] == 0) {//左下当たり判定
        data_count[i][j] = 1;
        fill(0, 255, 0);
        stroke(0);
        rect(data_left[i][j], data_up[i][j], 50, 50);
        velocity_vector_y += 1;
        velocity_vector_x += 1;
        count_score += 1;
      }
      if (pow(data_right[i][j] - location.x, 2) + pow(location.y - data_under[i][j], 2) <= pow(r, 2) && data_count[i][j] == 0) {//右下当たり判定
        data_count[i][j] = 1;
        fill(0, 255, 0);
        stroke(0);
        rect(data_left[i][j], data_up[i][j], 50, 50);
        velocity_vector_y += 1;
        velocity_vector_x += 1;
        count_score += 1;
      }
      if (data_left[i][j] <= location.x && data_right[i][j] >= location.x && data_under[i][j] + r >= location.y && data_up[i][j] + r < location.y && data_count[i][j] == 0) {//下当たり判定  
        data_count[i][j] = 1;
        fill(255, 0, 0);
        stroke(0);
        rect(data_left[i][j], data_up[i][j], 50, 50);
        velocity_vector_y += 1;
        count_score += 1;
      }
      if (data_left[i][j] <= location.x && data_right[i][j] >= location.x && data_up[i][j] - r <= location.y && data_under[i][j] - r > location.y && data_count[i][j] == 0) {//上当たり判定
        data_count[i][j] = 1;
        fill(255, 0, 0);
        stroke(0);
        rect(data_left[i][j], data_up[i][j], 50, 50);
        velocity_vector_y += 1;
        count_score += 1;
      }
      if (data_up[i][j] >= location.y && data_under[i][j] <= location.y && data_right[i][j] + r >= location.x && data_left[i][j] + r < location.x && data_count[i][j] == 0) {//右当たり判定
        data_count[i][j] = 1;
        fill(255, 0, 0);
        stroke(0);
        rect(data_left[i][j], data_up[i][j], 50, 50);
        velocity_vector_x += 1;
        count_score += 1;
      }
      if (data_up[i][j] >= location.y && data_under[i][j] <= location.y && data_left[i][j] - r <= location.x && data_right[i][j] -r > location.x && data_count[i][j] == 0) {//左当たり判定
        data_count [i][j] = 1;
        fill(255, 0, 0);
        stroke(0);
        rect(data_left[i][j], data_up[i][j], 50, 50);
        velocity_vector_x += 1;
        count_score += 1;
      }
      if (velocity_vector_x > 0) {//当たり判定からの合計値から速度ベクトルの変更
        velocity.x *= -1;
      }
      if (velocity_vector_y > 0) {
        velocity.y *= -1;
      }
      velocity_vector_x *= 0;
      velocity_vector_y *= 0;
    }
  }
  textSize(50);//スコアの表示
  fill(0);
  text(count_score, 50, 50);
  println(velocity_vector_y);

  timer_play = millis() - timer_title ;//時間制限30秒の管理
  fill(255, 255, 255, 100);
  stroke(0);
  strokeWeight(4);
  arc(width / 2, 70, 50, 50, timer_play * 1.3 / 1000  / TWO_PI, TWO_PI );
  fill(0);
  textSize(40);
  text(30 - (timer_play / 1000), width/2 - 25, 80);
  if (30 - (timer_play / 1000) <= 0) {//ゲーム終了画面へ
    timer_play = 0;
    state = 2;
  }
  acceleration.mult(0);//加速度をリセット
}
