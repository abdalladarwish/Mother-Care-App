#ifndef HTTP_H
#define HTTP_H
#include <Arduino.h>
void HTTP_config(char *baseUrl);
void HTTP_deviceConnectWithServer(char *endpoint);
void HTTP_sendSensorsData(char * endpoint, int deviceId ,float roomTemperature, float bodyTemperature, String position, int32_t heartRate, int32_t spo2);
#endif