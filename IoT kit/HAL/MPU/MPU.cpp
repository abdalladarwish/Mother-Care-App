#include "MPU.h"
#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>

static Adafruit_MPU6050 mpu;
sensors_event_t a, g, temp;

static float gyro[GYRO_ARR_SIZE];
static float acc[ACC_ARR_SIZE];
static float roomTemperature;

//Gyroscope sensor deviation
//offset
static float gyroXerror = 0.07;
static float gyroYerror = 0.03;
static float gyroZerror = 0.01;

bool MPU_checkExistance(void)
{
    bool status = mpu.begin(0x68);
    if (!status)
    {
        Serial.println("Could not find a mpu sensor, check wiring!");
        return false;
    }
    return true;
}

float *MPU_getGyroReadings(void)
{
    float gyroX_temp = g.gyro.x;
    if (abs(gyroX_temp) > gyroXerror)
    {
        gyro[0] += gyroX_temp / 50.00;
    }

    float gyroY_temp = g.gyro.y;
    if (abs(gyroY_temp) > gyroYerror)
    {
        gyro[1] += gyroY_temp / 70.00;
    }

    float gyroZ_temp = g.gyro.z;
    if (abs(gyroZ_temp) > gyroZerror)
    {
        gyro[2] += gyroZ_temp / 90.00;
    }
    return gyro;
}

void MPU_getReadings(void){
    mpu.getEvent(&a, &g, &temp);
}

float *MPU_getAccReadings(void)
{
    // Get current acceleration values
    acc[0] = a.acceleration.x;
    acc[1] = a.acceleration.y;
    acc[2] = a.acceleration.z;
    return acc;
}

float MPU_getRoomTemperature(void)
{
    roomTemperature = temp.temperature;
    Serial.println("roomTemp: "+ String(roomTemperature));
    return roomTemperature;
}

String getPosition(void)
{
    if ((((a.acceleration.x) >= 9) && ((a.acceleration.x) <= 10)))
    {
        Serial.print("Right");
        return "R";
    }

    else if ((((a.acceleration.x) >= (-10)) && ((a.acceleration.x) <= (-9))))
    {
        Serial.print("Left");
        return "L";
    }

    else if ((((a.acceleration.x) >= (-0.8)) && ((a.acceleration.x) <= (-0.5))))
    {
        Serial.print("Back");
        return "B";
    }

    else if ((((a.acceleration.x) >= 1) && ((a.acceleration.x) <= 3)))
    {
        Serial.print("Face");
        return "F";
    }
    else
    {
        Serial.print("Upnormal Position");
        return "Undefined";
    }
}