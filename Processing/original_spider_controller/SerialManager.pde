class SerialManager
{
  // member variable
  Serial port;
  String device_name = "";
  boolean is_connected;

  /*** member function
  *コンストラクタ
  *SerialManager(String device_name, int baudrate)
  *int available()
  *void clear()
  *int read()
  *char readChar()
  *String readString()
  *void stop()
  *void write(int data)
  *void write(char data)
  *void write(String data)
  ***/
  
  SerialManager(PApplet Parent, String tmp_device_name, int baudrate)
  {
    print(tmp_device_name + ": ");
    try
    {
      port = new Serial(Parent, tmp_device_name, baudrate);
      println("OK");
      device_name = tmp_device_name;
      is_connected = true;
      println("serial open");
    }
    catch(Exception e)
    {
      println("failed");
      is_connected = false;
    }
  }

  int available()
  {
    if (is_connected)
    {
      return port.available();
    }
    else
    {
      return -1;
    }
  }

  void clear()
  {
    if (is_connected)
    {
      port.clear();
    }
  }

  int read()
  {
    if (is_connected)
    {
      return port.read();
    }
    else
    {
      return -1;
    }
  }

  char readChar()
  {
    if (is_connected)
    {
      return port.readChar();
    }
    else
    {
      return '0';
    }
  }

  String readString()
  {
    if (is_connected)
    {
      return port.readString();
    }
    else
    {
      return null;
    }
  }

  String readStringUntil(char c)
  {
    if (is_connected)
    {
      return port.readStringUntil(c);
    }
    else
    {
      return null;
    }
  }

  void stop()
  {
    if (is_connected)
    {
      port.stop();
    }
  }

  void write(int data)
  {
    if (is_connected)
    {
      port.write(data);
    }
  }

  void write(char data)
  {
    if (is_connected)
    {
      port.write(data);
    }
  }

  void write(String data)
  {
    if (is_connected)
    {
      port.write(data);
    }
  }
};
