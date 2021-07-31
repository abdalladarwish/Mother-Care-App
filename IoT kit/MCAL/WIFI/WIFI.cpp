#include "WIFI.h"
#include <WiFi.h>
#include <Arduino.h>

void WIFI_connect(char *ssid, char *password)
{
    WiFi.begin(ssid, password); //WiFi connection

    while (WiFi.status() != WL_CONNECTED)
    { //Wait for the WiFI connection completion
        delay(500);
        Serial.println("Waiting for connection");
    }
    return;
}

WIFI_StatusType WIFI_getStatus(void)
{
    return WiFi.status();
}