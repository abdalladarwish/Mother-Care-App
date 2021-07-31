#include "MAX.h"
#include "MPU.h"
#include "Timer.h"
#include "BodyTemperature.h"
#include "HTTP.h"
#include "WIFI.h"
#include "DIO.h"

void setup(void)
{
    Serial.begin(115200);
    MAX_checkExistance();
    byte ledBrightness = 60; //Options: 0=Off to 255=50mA
    byte sampleAverage = 4;  //Options: 1, 2, 4, 8, 16, 32
    byte ledMode = 2;        //Options: 1 = Red only, 2 = Red + IR, 3 = Red + IR + Green
    byte sampleRate = 100;   //Options: 50, 100, 200, 400, 800, 1000, 1600, 3200
    int pulseWidth = 411;    //Options: 69, 118, 215, 411
    int adcRange = 4096;     //Options: 2048, 4096, 8192, 16384
    MAX_config(ledBrightness, sampleAverage, ledMode, sampleRate, pulseWidth, adcRange);
    MPU_checkExistance();
}

void loop()
{
    MAX_getSPO2AndHeartRate();
    MPU_getReadings();
    delay(10);
    MPU_getRoomTemperature();
    getPosition();
    
}
