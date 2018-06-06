int r=5;//ball radius size
int count=0;//reflect count num
PVector location;
PVector velocity;
int racket;
int data_x=16;
int data_y=6;
int [][] data_up = new int [data_x][data_y];
int [][] data_under = new int [data_x][data_y];
int [][] data_right = new int [data_x][data_y];
int [][] data_left = new int [data_x][data_y];
int [][] data_count = new int [data_x][data_y];
void setup() {
  size(700, 600);
  location=new PVector(100,100);
  velocity=new PVector(2,2);
  location.x=width/2;
  location.y=500;
}
void draw() {
  background(255);
  location.add(velocity);
  if (location.x>width-r||location.x<0+r) {
    velocity.x=velocity.x*-1;
  }
  if (location.y>height-r||location.y<0+r) {
    velocity.y=velocity.y*-1;
  }
  fill(0);
  ellipseMode(RADIUS);
  ellipse(location.x, location.y, r, r);
  rect(racket, 550, 50, 3);
  for (int i = 0; i < data_x; i=i+1) {
    for (int j = 0; j <data_y; j= j + 1) {
      if (data_count[i][j] != 1) {
        data_count [i][j] = 0;
      }
    }
  }
  for (int i=0;i<data_x;i=i+1) {
    for (int j=0;j<data_y;j=j+1) {
      if (data_count [i][j] == 0 ) {
        fill(255);//box color
        rect(i*50, j*50+50, 50, 50);//box
        data_up [i][j] = j*50+50;
        data_under [i][j] = j*50+100;
        data_left [i][j] = i*50;
        data_right [i][j] = i*50+50;
        //count=0;
      }
    }
  }
  for (int i=0;i<data_x;i=i+1) {
    for (int j=0;j<6;j=j+1) {
      if ((data_left[i][j]<=location.x&&data_right[i][j]>=location.x&&data_under[i][j]+r>=location.y&&data_up[i][j]+r<location.y&&data_count[i][j]==0)||//under
        (data_left[i][j]<=location.x&&data_right[i][j]>=location.x&&data_up[i][j]-r<=location.y&&data_under[i][j]-r>location.y&&data_count[i][j]==0)||//up
        (data_up[i][j]>location.y&&data_under[i][j]<location.y&&data_right[i][j]+r>=location.x&&data_left[i][j]+r<location.x&&data_count[i][j]==0)||//right
        (data_up[i][j]>location.y&&data_under[i][j]<location.y&&data_left[i][j]-r<=location.x&&data_right[i][j]-r>location.x&&data_count[i][j]==0)) {//left
        if (data_count[i][j]==0) {
          data_count [i][j] = 1;
          fill(255,0,0);
          rect(data_left[i][j],data_up[i][j],50,50);
          velocity.y*=-1;
          count=count+1;
        }
      }
    }
  }
  if (mouseX-25<0) {//mouse_screan_over
    racket=0;
  } else {
    if (mouseX-25>width-50) {
      racket=width-50;
    } else {
      racket=mouseX-25;
    }
  } 
  if (checkHit_racket(location.x, location.y)) {//refrect_racket
    velocity.y=velocity.y*-1;
    ;
    count+=1;
  }

  text(count, 10, 10);//show count
}
