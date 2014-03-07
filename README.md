pIOIO_PIR
=========

Android-Processing IOIO example using a passive infrared (PIR) sensor as digital input.

### How to use Processing in Android Mode
   * <a href="http://processing.org/tutorials/android/">Android Processing Tutorial</a> by Jer Thorp
   * <a href="http://wiki.processing.org/w/Android">Android Processing Wiki</a>

### IOIO Processing library
  * <a href="https://github.com/PinkHatSpike/pioio">PIOIO</a> by PinkHatSpike

### Hardware used
  * <a href="https://www.sparkfun.com/products/11343">IOIO-OTG</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9434">Bluetooth USB Module Mini</a> from Sparkfun
  * <a href="http://www.adafruit.com/products/328">Lithium Ion Polymer Battery - 3.7v 2500mAh</a> from Adafruit
  * <a href="https://www.sparkfun.com/products/12043">Breadboard - Mini Modular (White)</a> from Sparkfun
  * <a href="https://www.sparkfun.com/products/9140">Jumper Wires Premium 6" M/F</a> from Sparkfun
  * <a href="http://www.amazon.com/Samsung-Nexus-Android-Phone-Sprint/dp/B0050DDVUI">Nexus S 4G</a> by Samsung (any Android phone will do)
  * <a href="https://www.sparkfun.com/products/9594">LED - Basic Yellow 5mm</a> from Sparkfun

### LED wiring
  * Connect the GND pin to ground (GND) on the IOIO board
  * Connect the VCC pin to 3.3v on the IOIO board.
  * Connect the OUT pin to pin #1 on the IOIO board.

### Step 1: Importing Libraries / Android
First we have to add appropriate IOIO libraries and parts of the Android API, this happens before the setup loop.
```
import ioio.lib.api.*;
import ioio.lib.api.exception.*;
import com.pinkhatproductions.pioio.*;

import android.view.Window;
import android.view.WindowManager;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.bluetooth.*;
```

### Step 2: Adding global variables
Also before the setup loop, we name our LED and declare a boolean to control our light and an integer for our color.

2a. Name the sensor input variable and specify that it's a digital input.
```
DigitalInput PIRmove;
```
2b. Make a boolean to show if there's movement detected by the sensor.
```
boolean isMoving = false;
```
2c. Create an integer for our background color.
```
int bcolor = 0;
```

### Step 3: Processing setup
The setup chunk is ran once at the begining of the sketch and is in the `void setup()` funtion, here we start the PIOIO communication and declare the size of our sketch as well as choose the orientation of our sketch.

3a. Instantiate pIOIO
```
  new PIOIOManager(this).start();
```
3b. Set the size of the Android application, you can specify specific pixel dimensions or have it auto-detect the display width and display height of the device. P3D is the render mode, in case later you need something to be 3D.
```
  size(displayWidth, displayHeight, P3D);
```
3c. Set the orientation of the Android application, here it's portrait but you could also choose `orientation(LANDSCAPE)` or not include this if you don't want to lock the orientation.
```
  orientation(PORTRAIT); //orientation of sketch
```
3d. Set the text that will be displayed on the screen to be center-aligned and centered vertically.
```
  textAlign(CENTER, CENTER);
```
3e. Set the size of the text to be 36 pixels.
```
  textSize(36);
```

### Step 4: Processing draw loop
The draw loop is run ~60 times per second default and is in the `void draw()` function.

4a. Draw the background color of the sketch.
```
  background(bcolor);
```
4b. If-else statement where if movement is detected, the background color of the application turns white, the text color turns black and the text displays "Moving" in the center of the screen. If there is no movement, the background color of the application turns black, the text color turns white and the text displays "Not Moving".
```
  if (isMoving) {
    bcolor = 255;
    fill(0);
    text("Moving", 0, 0, width, height);
  }
  else {
    bcolor = 0;
    fill(255);
    text("Not Moving", 0, 0, width, height);
  }
```

### Step 5: IOIO thread setup
The IOIO functionality resides in a separate paralell thread that is structured similarly to the Processing `void setup()` and `void draw()` functions. The IOIO setup is in the `void ioioSetup(IOIO ioio)` function and is basically Java and only executes if it's connected to the IOIO. The function declaration is followed by `throws ConnectionLostException` before the opening curly bracket.

In the IOIO thread setup we link our `PIRmove` variable to pin #1 on the board and declare that it is to be used for digital input.
```
  PIRmove = ioio.openDigitalInput(1);
```

### Step 6: IOIO thread loop
The IOIO thread loop mirrors the functionality of the `void draw()` processing funtion, is also basically Java and also only executes if it's connected to the IOIO. The function declaration is also followed by `throws ConnectionLostException` before the opening curly bracket.

6a. The try block checks our pin to see if it's high or low. If it's high, the `isMoving` boolean returns true.
```
  try {
    isMoving = PIRmove.read();
    Thread.sleep(20);
  }
```
6b. The catch block is an exception handler and throws an error if there is an interruption.
```
  catch (ConnectionLostException e) {
  }
```
