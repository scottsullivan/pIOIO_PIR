// - - - - - - - - - - - - - - - - - - - - - - - 
// IOIO THREAD SETUP
// - - - - - - - - - - - - - - - - - - - - - - - 
void ioioSetup(IOIO ioio) throws ConnectionLostException {
  PIRmove = ioio.openDigitalInput(1);
}

// - - - - - - - - - - - - - - - - - - - - - - - 
// IOIO THREAD LOOP
// - - - - - - - - - - - - - - - - - - - - - - - 
void ioioLoop(IOIO ioio) throws ConnectionLostException {
  try {
    isMoving = PIRmove.read();
    Thread.sleep(20);
  }
  catch (InterruptedException e) {
  }
}
