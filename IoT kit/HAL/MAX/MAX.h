#ifndef MAX_H
#define MAX_H
#include <Arduino.h>
#include "MAX30105.h"

#define MAX_BRIGHTNESS 255
#ifndef MAX_BUFFER_DATA_SIZE
#define MAX_BUFFER_DATA_SIZE 100U
#endif

bool MAX_checkExistance(void);

void MAX_config(unsigned char powerLevel = 0x1F, unsigned char sampleAverage = 4, unsigned char ledMode = 3, int sampleRate = 400, int pulseWidth = 411, int adcRange = 4096);

bool MAX_getSPO2Value(int32_t * spo2Value);

bool MAX_getHeartRateValue(int32_t * _heartRate);

void MAX_getSPO2AndHeartRate(void);

#endif