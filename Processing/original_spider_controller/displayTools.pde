/***
*描画補助用関数の寄せ集め
***/

void showText3d(String str, int x, int y)
{
  pushMatrix();
  camera();
  hint(DISABLE_DEPTH_TEST);
  noLights();
  textMode(MODEL);
  text(str, x, y);
  hint(ENABLE_DEPTH_TEST);
  popMatrix();
}

void rightHandedRotateX(float rad_angle)
{
  rotateZ(-rad_angle);
}

void rightHandedRotateY(float rad_angle)
{
  rotateX(-rad_angle);
}

void rightHandedRotateZ(float rad_angle)
{
  rotateY(rad_angle);
}

void makeLinkX(float link_length)
{
  stroke(50);
  translate(0, 0, link_length / 2);
  box(20,20,abs(link_length));
  translate(0, 0, link_length / 2);
}

void makeLinkY(float link_length)
{
  stroke(50);
  translate(link_length / 2, 0, 0);
  box(abs(link_length),20,20);
  translate(link_length / 2, 0, 0);
}

void makeLinkZ(float link_length)
{
  stroke(50);
  translate(0, -link_length / 2, 0);
  box(20,abs(link_length),20);
  translate(0, -link_length / 2, 0);
}

//円筒の描画
void makeCylinder()
{
  noStroke();
  beginShape(QUAD_STRIP);
    for  (int a = 0; a <= 360; a += 10)  {
      float drawX = 15 * cos(radians(a));
      float drawY = 15 * sin(radians(a));
      vertex(drawY, -20, drawX);
      vertex(drawY, 20, drawX);
    }  
  endShape();
  translate(0, 20, 0);
  beginShape(QUAD_STRIP);
    for  (int a = 0; a <= 360; a += 10)  {
      float drawX = 15 * cos(radians(a));
      float drawY = 15 * sin(radians(a));
      vertex(drawY, 0, drawX);
      vertex(-drawY, 0, drawX);
    }  
  endShape();
  translate(0, -40, 0);
  beginShape(QUAD_STRIP);
    for  (int a = 0; a <= 360; a += 10)  {
      float drawX = 15 * cos(radians(a));
      float drawY = 15 * sin(radians(a));
      vertex(drawY, 0, drawX);
      vertex(-drawY, 0, drawX);
    }  
  endShape();
  translate(0, 20, 0);
}

//多角形円筒の描画
void makePolygonPillar(float size, float pillar_height, int stroke_num)
{
  noStroke();
  beginShape(QUAD_STRIP);
    int delta = 360 / stroke_num;
    for  (int a = 0; a <= 360; a += delta)  {
      float drawX = size * cos(radians(a));
      float drawY = size * sin(radians(a));
      vertex(drawY, -pillar_height / 2, drawX);
      vertex(drawY, pillar_height / 2, drawX);
    }  
  endShape();
  translate(0, pillar_height / 2, 0);
  beginShape(QUAD_STRIP);
    for  (int a = 0; a <= 360; a += delta)  {
      float drawX = size * cos(radians(a));
      float drawY = size * sin(radians(a));
      vertex(drawY, 0, drawX);
      vertex(-drawY, 0, drawX);
    }  
  endShape();
  translate(0, -pillar_height, 0);
  beginShape(QUAD_STRIP);
    for  (int a = 0; a <= 360; a += delta)  {
      float drawX = size * cos(radians(a));
      float drawY = size * sin(radians(a));
      vertex(drawY, 0, drawX);
      vertex(-drawY, 0, drawX);
    }  
  endShape();
  translate(0, pillar_height / 2, 0);
}

void arrow(int x1, int y1, int z1, int x2, int y2, int z2, int Color1, int Color2, int Color3)
{
  int arrowLength = 10;
  float arrowAngle = 0.5;
  float phi = -atan2(y2-y1, x2-x1);
  float theta = PI/2-atan2(z2-z1, x2-x1);
  stroke(Color1, Color2, Color3);
  line(x1, y1, z1, x2, y2, z2);
  //サンプルコードではpush-popMatrixを使用
  translate(x2, y2, z2);
  rotateY(theta);
  rotateX(phi);
  cone(arrowLength, arrowLength*sin(arrowAngle), Color1, Color2, Color3);
  rotateX(-phi);
  rotateY(-theta);
  translate(-x2, -y2, -z2);
}

void cone(int L, float radius, int Color1, int Color2, int Color3)
{
  float x, y;
  noStroke();
  fill(Color1, Color2, Color3);
  beginShape(TRIANGLE_FAN);  // 底面の円の作成
  vertex(0, 0, -L);
  for(float i=0; i<2*PI; )
  {
    x = radius*cos(i);
    y = radius*sin(i);
    vertex(x, y, -L);
    i = i+0.01;
  }
  endShape(CLOSE);
  beginShape(TRIANGLE_FAN);  // 側面の作成
  vertex(0, 0, 0);
  for(float i=0; i<2*PI; )
  {
    x = radius*cos(i);
    y = radius*sin(i);
    vertex(x, y, -L);
    i = i+0.01;
  }
  endShape(CLOSE);
}