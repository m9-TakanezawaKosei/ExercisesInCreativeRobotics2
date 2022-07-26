import org.gamecontrolplus.*;
import net.java.games.input.*;
import java.util.List;

ControlIO control;
ControlDevice gpad;
ControlSlider[] slider = new ControlSlider[5];
ControlButton[] button = new ControlButton[10];
ControlHat[]    hat    = new ControlHat[1];
List<ControlDevice> list;

int slider_LX, slider_LY, slider_RX, slider_RY, slider_FR;
int button_A, button_B, button_X, button_Y;
int button_LB, button_RB, button_Back, button_Start, button_LA, button_RA;
int hat_XY;
int control_counter = 0;

boolean gamepadExists()
{
  control = ControlIO.getInstance(this);
  list = control.getDevices();
  print(list);
  for (ControlDevice dev : list)
  {
    if (dev.getTypeName() == Controller.Type.GAMEPAD.toString())
    {
      gpad = dev;
      gpad.open();
      break;
    }
  }
  if (gpad == null)
  {
    println("ERROR: No available gamepad is found.");
    return false;
  }
  else
  {
    return true;
  }
}

void gamepadSetup()
{
  slider[0] = gpad.getSlider(0);  // Left  stick Up-Down
  slider[1] = gpad.getSlider(1);  // Left  stick Left-Right
  slider[2] = gpad.getSlider(2);  // Right stick Up-Down
  slider[3] = gpad.getSlider(3);  // Right stick Left-Right
  slider[4] = gpad.getSlider(4);  // Front slider +L -R

  button[0] = gpad.getButton(0);  // button_A
  button[0].plug(this, "A_ButtonPress", ControlIO.ON_PRESS);
  button[0].plug(this, "A_ButtonRelease", ControlIO.ON_RELEASE);
  button[1] = gpad.getButton(1);  // button_B
  button[1].plug(this, "B_ButtonPress", ControlIO.ON_PRESS);
  button[1].plug(this, "B_ButtonRelease", ControlIO.ON_RELEASE);
  button[2] = gpad.getButton(2);  // button_X
  button[2].plug(this, "X_ButtonPress", ControlIO.ON_PRESS);
  button[2].plug(this, "X_ButtonRelease", ControlIO.ON_RELEASE);
  button[3] = gpad.getButton(3);  // button_Y
  button[3].plug(this, "Y_ButtonPress", ControlIO.ON_PRESS);
  button[3].plug(this, "Y_ButtonRelease", ControlIO.ON_RELEASE);
  button[4] = gpad.getButton(4);  // button_LB
  button[4].plug(this, "LB_ButtonPress", ControlIO.ON_PRESS);
  button[4].plug(this, "LB_ButtonRelease", ControlIO.ON_RELEASE);
  button[5] = gpad.getButton(5);  // button_RB
  button[5].plug(this, "RB_ButtonPress", ControlIO.ON_PRESS);
  button[5].plug(this, "RB_ButtonRelease", ControlIO.ON_RELEASE);
  button[6] = gpad.getButton(6);  // button_Back
  button[6].plug(this, "Back_ButtonPress", ControlIO.ON_PRESS);
  button[6].plug(this, "Back_ButtonRelease", ControlIO.ON_RELEASE);
  button[7] = gpad.getButton(7);  // button_Start
  button[7].plug(this, "Start_ButtonPress", ControlIO.ON_PRESS);
  button[7].plug(this, "Start_ButtonRelease", ControlIO.ON_RELEASE);
  button[8] = gpad.getButton(8);  // button_LA
  button[8].plug(this, "LA_ButtonPress", ControlIO.ON_PRESS);
  button[8].plug(this, "LA_ButtonRelease", ControlIO.ON_RELEASE);
  button[9] = gpad.getButton(9);  // button_RA
  button[9].plug(this, "RA_ButtonPress", ControlIO.ON_PRESS);
  button[9].plug(this, "RA_ButtonRelease", ControlIO.ON_RELEASE);

  hat[0] = gpad.getHat(10);       // hat_XY
  hat[0].plug(this, "HatPress", ControlIO.WHILE_PRESS);
  hat[0].plug(this, "HatRelease", ControlIO.ON_RELEASE);
}

void A_ButtonPress()
{
  button_A += 1;
  control_counter++;
}

void A_ButtonRelease()
{
  button_A -= 1;
}

void B_ButtonPress()
{
  button_B += 1;
  control_counter++;
}

void B_ButtonRelease()
{
  button_B -= 1;
}

void X_ButtonPress()
{
  button_X += 1;
  control_counter++;
}

void X_ButtonRelease()
{
  button_X -= 1;
}

void Y_ButtonPress()
{
  button_Y += 1;
  control_counter++;
}

void Y_ButtonRelease()
{
  button_Y -= 1;
}

void LB_ButtonPress()
{
  button_LB += 1;
  control_counter++;
}

void LB_ButtonRelease()
{
  button_LB -= 1;
}

void RB_ButtonPress()
{
  button_RB += 1;
  control_counter++;
}

void RB_ButtonRelease()
{
  button_RB -= 1;
}

void Back_ButtonPress()
{
  button_Back += 1;
  control_counter++;
}

void Back_ButtonRelease()
{
  button_Back -= 1;
}

void Start_ButtonPress()
{
  button_Start += 1;
  control_counter++;
}

void Start_ButtonRelease()
{
  button_Start -= 1;
}

void LA_ButtonPress()
{
  button_LA += 1;
  control_counter++;
}

void LA_ButtonRelease()
{
  button_LA -= 1;
}

void RA_ButtonPress()
{
  button_RA += 1;
  control_counter++;
}

void RA_ButtonRelease()
{
  button_RA -= 1;
}

int pred_hat_XY;
void HatPress(float x, float y)
{
  hat_XY = (int)hat[0].getValue();
  if (pred_hat_XY != hat_XY)
  {
    control_counter++;
  }

  pred_hat_XY = hat_XY;
}

void HatRelease(float x, float y)
{
  hat_XY = (int)hat[0].getValue();
}
