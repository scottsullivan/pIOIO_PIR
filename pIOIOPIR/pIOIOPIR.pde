// - - - - - - - - - - - - - - - - - - - - - - -
// PIOIO PIR SENSOR
// MIT License (MIT)
// Copyright (c) 2014 Scott Sullivan
// - - - - - - - - - - - - - - - - - - - - - - -

// - - - - - - - - - - - - - - - - - - - - - - - 
// LIBRARIES
// - - - - - - - - - - - - - - - - - - - - - - - 
import ioio.lib.api.*;
import ioio.lib.api.exception.*;
import com.pinkhatproductions.pioio.*;

// - - - - - - - - - - - - - - - - - - - - - - - 
// ANDROID IMPORT
// - - - - - - - - - - - - - - - - - - - - - - - 
import android.view.Window;
import android.view.WindowManager;
import android.content.pm.ActivityInfo;
import android.os.Bundle;
import android.bluetooth.*;

// - - - - - - - - - - - - - - - - - - - - - - - 
// GLOBAL VARIABLES
// - - - - - - - - - - - - - - - - - - - - - - - 
DigitalInput PIRmove;
boolean isMoving = false;
int bcolor = 0; //variable for the background color of the application

// - - - - - - - - - - - - - - - - - - - - - - - 
// SETUP
// - - - - - - - - - - - - - - - - - - - - - - - 
void setup() {
  new PIOIOManager(this).start(); //begin PIOIO
  
  size(displayWidth, displayHeight, P3D); //size of sketch
  orientation(PORTRAIT); //orientation of sketch
  textAlign(CENTER, CENTER);
  textSize(36);
}

// - - - - - - - - - - - - - - - - - - - - - - - 
// DRAW LOOP
// - - - - - - - - - - - - - - - - - - - - - - - 
void draw() {
  background(bcolor);
  
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
}
