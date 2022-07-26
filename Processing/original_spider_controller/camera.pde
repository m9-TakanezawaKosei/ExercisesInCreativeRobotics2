//左手系での視点の位置
float cameraX  = 1000/2;
float cameraY  = 0;
float cameraZ  = (450/2)/tan(PI/8);
float cameraX0 = 1000/2;
float cameraY0 = 0;
float cameraZ0 = (450/2)/tan(PI/8);

float mouseX0  = -1;
float mouseY0  = -1;
float mouseX1  = -1;
float mouseY1  = -1;
float cameraPitch = PI/2;
float cameraYaw = 0;


//カメラ座標の変更
void mouseDragged()
{
  mouseX1 = mouseX;
  mouseY1 = mouseY;
  if(mouseX0 == -1){
    mouseX0 = mouseX;
    mouseY0 = mouseY;
  }
  if(mouseX1 - mouseX0 > 0){
    cameraYaw -= PI/72;
  }else if(mouseX1 - mouseX0 < 0){
    cameraYaw += PI/72;
  }
  if(mouseY1 - mouseY0 > 0){
    cameraPitch -= PI/108;
    if(cameraPitch < 0){
      cameraPitch += PI/108;
    }
  }else if(mouseY1 - mouseY0 < 0){
    cameraPitch += PI/108;
    if(cameraPitch > PI){
      cameraPitch -= PI/108;
    }
  }
  cameraX = cameraX0 + cameraZ0 * sin(cameraPitch) * sin(cameraYaw);
  cameraY = cameraY0 - cameraZ0 * cos(cameraPitch);
  cameraZ = cameraZ0 * sin(cameraPitch) * cos(cameraYaw);
  mouseX0 = mouseX1;
  mouseY0 = mouseY1;
}
