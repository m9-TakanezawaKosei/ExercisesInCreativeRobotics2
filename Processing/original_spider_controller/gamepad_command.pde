/**
 gamepad入力に応じて動作を生成・実行
 動作の内容はleg_motion_commands，hand_motion_commandsを参照
**/

/**
使えるゲームパッドの変数一覧（グローバル変数）
int slider_LX, slider_LY, slider_RX, slider_RY, slider_FR;
int button_A, button_B, button_X, button_Y;
int button_LB, button_RB, button_Back, button_Start, button_LA, button_RA;
int hat_XY;
**/

int slider_x_threshold     = 20;
int slider_y_threshold     = 40;
int slider_f_threshold     = 50;
int pred_slider_front      = 50;
int walking_state_L        = 0;
int steering_state         = 1;
float robot_steering       = 0;

int[] walking_time_counts    = {0, 0, 0, 0};
int walking_time_threshold = 20;

boolean pred_key_pressed   = false;

void readGamePadCommand()
{
  if (slider_FR > slider_f_threshold || (keyPressed && keyCode == RIGHT))
  {
    if ((pred_slider_front <= slider_f_threshold && steering_state < 2) || (keyPressed && keyCode == RIGHT && steering_state < 2))
    {
      boolean rot_motion_is_moving = false;
      for (int i = 0; i < motion_list.motions.length; i++)
      {
        if (motion_list.motions[i].motion_name.contains("rotational+"))
        {
          rot_motion_is_moving = rot_motion_is_moving || motion_list.motions[i].is_moving;
        }
      }
      if (rot_motion_is_moving == false)
      {
        steering_state++;
        robot_steering = (float)(PI * (1 - steering_state) / 2);
        if (steering_state == 1)
        {
          rotationalMotion90(robot_steering, PI / 2);
        }
        else
        {
          rotationalMotion90(robot_steering, 0);
        }
      }
    }
    pred_slider_front = slider_FR;
  }
  else if (slider_FR < -slider_f_threshold || (keyPressed && keyCode == LEFT))
  {
    if ((pred_slider_front >= -slider_f_threshold && steering_state > 0) || (keyPressed && keyCode == LEFT && steering_state > 0))
    {
      boolean rot_motion_is_moving = false;
      for (int i = 0; i < motion_list.motions.length; i++)
      {
        if (motion_list.motions[i].motion_name.contains("rotational+"))
        {
          rot_motion_is_moving = rot_motion_is_moving || motion_list.motions[i].is_moving;
        }
      }
      if (rot_motion_is_moving == false)
      {
        steering_state--;
        robot_steering = (float)(PI * (1 - steering_state) / 2);
        if (steering_state == 1)
        {
          rotationalMotion90(robot_steering, -PI / 2);
        }
        else
        {
          rotationalMotion90(robot_steering, 0);
        }
      }
    }
    pred_slider_front = slider_FR;
  }
  else
  {
    pred_slider_front = slider_FR;
  }
  

  if (button_LB == 1 && button_RB == 1)
  {
    myPort.write("[n]\n");
    delay(10);
    return;
  }

  //ボタン
  if (button_A == 1)
  {
    wavingHandsMotion();
  }
  else if (button_B == 1)
  {
    if (button_LB == 1)
    {
      sweepingMotion(-20);
    }
    else if (button_RB == 1)
    {
      sweepingMotion(20);
    }
    else
    {
      sweepingMotion(0);
    }
  }
  else if (button_X == 1)
  {
    foldingMotion();
  }
  else if (button_Y == 1)
  {
    resetMotion(robot_steering);
  }


  //ジョイスティック
  if      (slider_LX >  slider_x_threshold && abs(slider_LY) <  slider_y_threshold) //L下
  {
    if (walking_state_L == 0 || walking_time_counts[0] > walking_time_threshold)
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        walking_time_counts[i] = 0;
      }
      walkingMotion(robot_steering, 3);
      walking_state_L = 0;
    }
    else
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        if (i == 0)
        {
          walking_time_counts[i]++;
        }
        else
        {
          walking_time_counts[i] = 0;
        }
      }
    }
  }
  else if (slider_LX < -slider_x_threshold && abs(slider_LY) <  slider_y_threshold) //L上
  {
    if (walking_state_L == 0 || walking_time_counts[0] > walking_time_threshold)
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        walking_time_counts[i] = 0;
      }
      walkingMotion(robot_steering, 0);
      walking_state_L = 0;
    }
    else
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        if (i == 0)
        {
          walking_time_counts[i]++;
        }
        else
        {
          walking_time_counts[i] = 0;
        }
      }
    }
  }
  else if (slider_LY >  slider_y_threshold && abs(slider_LX) <  slider_x_threshold) //L右
  {
    if (walking_state_L == 3 || walking_time_counts[3] > walking_time_threshold)
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        walking_time_counts[i] = 0;
      }
      sideWalkingMotion(robot_steering, 1);
      walking_state_L = 3;
    }
    else
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        if (i == 3)
        {
          walking_time_counts[i]++;
        }
        else
        {
          walking_time_counts[i] = 0;
        }
      }
    }
  }
  else if (slider_LY < -slider_y_threshold && abs(slider_LX) <  slider_x_threshold) //L左
  {
    if (walking_state_L == 3 || walking_time_counts[3] > walking_time_threshold)
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        walking_time_counts[i] = 0;
      }
      sideWalkingMotion(robot_steering, 0);
      walking_state_L = 3;
    }
    else
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        if (i == 3)
        {
          walking_time_counts[i]++;
        }
        else
        {
          walking_time_counts[i] = 0;
        }
      }
    }
  }
  else if (slider_LX >  slider_x_threshold &&     slider_LY  >  slider_y_threshold) //L右下
  {
    if (walking_state_L == 2 || walking_time_counts[2] > walking_time_threshold)
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        walking_time_counts[i] = 0;
      }
      walkingMotion(robot_steering, 5);
      walking_state_L = 2;
    }
    else
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        if (i == 2)
        {
          walking_time_counts[i]++;
        }
        else
        {
          walking_time_counts[i] = 0;
        }
      }
    }
  }
  else if (slider_LX >  slider_x_threshold &&     slider_LY  < -slider_y_threshold) //L左下
  {
    if (walking_state_L == 1 || walking_time_counts[1] > walking_time_threshold)
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        walking_time_counts[i] = 0;
      }
      walkingMotion(robot_steering, 4);
      walking_state_L = 1;
    }
    else
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        if (i == 1)
        {
          walking_time_counts[i]++;
        }
        else
        {
          walking_time_counts[i] = 0;
        }
      }
    }
  }
  else if (slider_LX < -slider_x_threshold &&     slider_LY  >  slider_y_threshold) //L右上
  {
    if (walking_state_L == 1 || walking_time_counts[1] > walking_time_threshold)
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        walking_time_counts[i] = 0;
      }
      walkingMotion(robot_steering, 1);
      walking_state_L = 1;
    }
    else
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        if (i == 1)
        {
          walking_time_counts[i]++;
        }
        else
        {
          walking_time_counts[i] = 0;
        }
      }
    }
  }
  else if (slider_LX < -slider_x_threshold &&      slider_LY  < -slider_y_threshold) //L左上
  {
    if (walking_state_L == 2 || walking_time_counts[2] > walking_time_threshold)
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        walking_time_counts[i] = 0;
      }
      walkingMotion(robot_steering, 2);
      walking_state_L = 2;
    }
    else
    {
      for (int i = 0; i < walking_time_counts.length; i++)
      {
        if (i == 2)
        {
          walking_time_counts[i]++;
        }
        else
        {
          walking_time_counts[i] = 0;
        }
      }
    }
  }
  else if (slider_RX >  slider_x_threshold && abs(slider_RY) <  slider_y_threshold) //R下
  {
    backJumpingMotion(robot_steering, 0);
  }
  else if (slider_RX < -slider_x_threshold && abs(slider_RY) <  slider_y_threshold) //R上
  {
    jumpingMotion(robot_steering, 0);
  }
  else if (slider_RY >  slider_y_threshold && abs(slider_RX) <  slider_x_threshold) //R右
  {
    jumpingMotion(robot_steering, 1);
  }
  else if (slider_RY < -slider_y_threshold && abs(slider_RX) <  slider_x_threshold) //R左
  {
    jumpingMotion(robot_steering, 2);
  }
  else if (slider_RX >  slider_x_threshold &&     slider_RY  >  slider_y_threshold) //R右下
  {
    backJumpingMotion(robot_steering, 1);
  }
  else if (slider_RX >  slider_x_threshold &&     slider_RY  < -slider_y_threshold) //R左下
  {
    backJumpingMotion(robot_steering, 1);
  }
  else if (slider_RX < -slider_x_threshold &&     slider_RY  >  slider_y_threshold) //R右上
  {
    jumpingMotion(robot_steering, 1);
  }
  else if (slider_RX < -slider_x_threshold &&     slider_RY  < -slider_y_threshold) //R左上
  {
    jumpingMotion(robot_steering, 2);
  }

  //十字キー
  if (hat_XY == 2)
  {
    spreadMotion(robot_steering);
  }
  else if (hat_XY == 1)
  {}
  else if (hat_XY == 3)
  {}
  else if (hat_XY == 8)
  {
    rotationalMotion(robot_steering, -PI / 4);
  }
  else if (hat_XY == 4)
  {
    rotationalMotion(robot_steering, PI / 4);
  }
  else if (hat_XY == 6)
  {
    shrinkMotion(robot_steering);
  }
  else if (hat_XY == 5)
  {}
  else if (hat_XY == 7)
  {}


  //テスト用キーボード操作
  if(is_simulation)
  {
    if (pred_key_pressed == false && keyPressed && key == '1')
    {
      wavingHandsMotion();
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == '2')
    {
      sweepingMotion(0);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == '3')
    {
      sweepingMotion(20);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == '4')
    {
      sweepingMotion(-20);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == '5')
    {
      rotationalMotion(robot_steering, PI / 4);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == '6')
    {
      rotationalMotion(robot_steering, -PI / 4);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == '7')
    {
      spreadMotion(robot_steering);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == '8')
    {
      shrinkMotion(robot_steering);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == '9')
    {
      foldingMotion();
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'q')
    {
      resetMotion(robot_steering);
      control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'w')
    {
      walkingMotion(robot_steering, 0);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'e')
    {
      walkingMotion(robot_steering, 1);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'r')
    {
      walkingMotion(robot_steering, 2);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 't')
    {
      walkingMotion(robot_steering, 3);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'y')
    {
      walkingMotion(robot_steering, 4);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'u')
    {
      walkingMotion(robot_steering, 5);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'i')
    {
      sideWalkingMotion(robot_steering, 0);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'o')
    {
      sideWalkingMotion(robot_steering, 1);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'z')
    {
      jumpingMotion(robot_steering, 0);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'x')
    {
      jumpingMotion(robot_steering, 1);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'c')
    {
      jumpingMotion(robot_steering, 2);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'v')
    {
      backJumpingMotion(robot_steering, 0);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'b')
    {
      backJumpingMotion(robot_steering, 1);
      //control_counter++;
    }
    else if (pred_key_pressed == false && keyPressed && key == 'n')
    {
      backJumpingMotion(robot_steering, 2);
      //control_counter++;
    }


    if (keyPressed)
    {
      pred_key_pressed = true;
    }
    else
    {
      pred_key_pressed = false;
    }
  }
}
