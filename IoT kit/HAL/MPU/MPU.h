#ifndef MPU_H
#define MPU_H
#define GYRO_ARR_SIZE 3
#define ACC_ARR_SIZE 3
#include <Arduino.h>
bool MPU_checkExistance(void);
void MPU_getReadings(void);
float* MPU_getGyroReadings(void);
float* MPU_getAccReadings(void);
float MPU_getRoomTemperature(void);
String getPosition(void);
#endif