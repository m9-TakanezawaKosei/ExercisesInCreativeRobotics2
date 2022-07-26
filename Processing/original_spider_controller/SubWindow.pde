public class SubWindow extends PApplet
{
  // settings を必ず実装する
  void settings()
  {
    size(600, 800, P3D);
  }
  void setup()
  {
    gamepadSetup();
    smooth();
    frameRate(250);
  }
  void draw()
  {
    gamepadDraw();
  }

  void gamepadDraw()
  {
    background(0);
    textUpDate();
  }

  void textUpDate()
  {
    slider_LX = int(slider[0].getValue()*100);
    slider_LY = int(slider[1].getValue()*100);
    slider_RX = int(slider[2].getValue()*100);
    slider_RY = int(slider[3].getValue()*100);
    slider_FR = int(slider[4].getValue()*100);

    textSize(24);
    fill(240);
    textAlign(RIGHT);
    text("slider_LX U-D", 200, 40);
    text(slider_LX, 300, 40);
    text("slider_LY L-R", 200, 80);
    text(slider_LY, 300, 80);
    text("slider_RX U-D", 200, 120);
    text(slider_RX, 300, 120);
    text("slider_RY L-R", 200, 160);
    text(slider_RY, 300, 160);
    text("slider_FR +L -R", 200, 200);
    text(slider_FR, 300, 200);

    text("button_A", 200, 240);
    text(button_A, 300, 240);
    text("button_B", 200, 280);
    text(button_B, 300, 280);
    text("button_X", 200, 320);
    text(button_X, 300, 320);
    text("button_Y", 200, 360);
    text(button_Y, 300, 360);
    text("button_LB", 200, 400);
    text(button_LB, 300, 400);
    text("button_RB", 200, 440);
    text(button_RB, 300, 440);
    text("button_Back", 200, 480);
    text(button_Back, 300, 480);
    text("button_Start", 200, 520);
    text(button_Start, 300, 520);
    text("button_LA", 200, 560);
    text(button_LA, 300, 560);
    text("button_RA", 200, 600);
    text(button_RA, 300, 600);

    text("hat_XY", 200, 640);
    text(hat_XY, 300, 640);
  }
}
