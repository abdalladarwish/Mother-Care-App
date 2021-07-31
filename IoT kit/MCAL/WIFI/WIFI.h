#ifndef WIFI_H
#define WIFI_H
#include <WiFi.h>
typedef wl_status_t WIFI_StatusType;
void WIFI_connect(char * ssid, char * password);

WIFI_StatusType WIFI_getStatus(void);
#endif