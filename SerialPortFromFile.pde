import processing.serial.*;

// serial object
Serial mySerial = null;

// configuration file
final String configFile = "data/PortConfig.txt";

// baudrate
final int baudrate = 115200;
// serial port selected by user; one can set this to a default (e.g. COM8)
String selectedPort = "";

// the end maker
final char endMarker = '\n';
// data received on serial port
String receivedData = null;

// message to display
String displayMessage= "";

void setup()
{
  size(350, 400);

  // possible Processing bug
  // when the application starts, it does not always react on key presses
  //   and one has to manucally click in the application to give it the focus
  // workaround that might solve it found at https://discourse.processing.org/t/keypressed-only-works-sometimes/22340/
  surface.setVisible(true);

  // if read port from file succeeded
  if (readPortFromFile() == true)
  {
    // if the specified port exists
    if (chkPortExists() == true)
    {
      try
      {
        mySerial = new Serial(this, selectedPort, baudrate);
        displayMessage = "Port " + selectedPort + "' is open";
      }
      catch(RuntimeException rtex)
      {
        displayMessage = rtex.getMessage();
      }
    }
  }
}

void draw()
{
  background(0xFFFFF1C4);
  textSize(16);
  textAlign(CENTER, CENTER);
  if (mySerial == null)
  {
    fill(0xFF800000);
  } //
  else
  {
    fill(0xFF008000);
  }
  text(displayMessage, width/2, height / 2);
}

/*
Retrieve port-to-use from file
 Returns:
 true on successfu read, else false
 */
boolean readPortFromFile()
{
  boolean success = true;
  try
  {
    BufferedReader reader = createReader(configFile);
    // if the file was not opened
    if (reader == null)
    {
      displayMessage = "Could not open file '" + configFile + "'";
      success = false;
    } //
    else
    {
      selectedPort = reader.readLine();
    }
  }
  catch (Exception ex)
  {
    displayMessage = ex.getMessage();
    success = false;
  }

  return success;
}

/*
Check if selected port exists
 Returns:
 true if it exists, else false
 */
boolean chkPortExists()
{
  boolean portExists = false;
  // loop through the list of ports
  for (int pCnt = 0; pCnt < Serial.list().length; pCnt++)
  {
    // if specified port exists in the list
    if (Serial.list()[pCnt].equals(selectedPort) == true)
    {
      portExists = true;
      break;
    }
  }
  // if the specified port does not exists in the list
  if (portExists == false)
  {
    displayMessage = "Serial port '" + selectedPort + "' does not exist";
  }

  return portExists;
}
