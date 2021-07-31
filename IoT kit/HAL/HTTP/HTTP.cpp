#include "HTTP.h"
#include "WIFI.h"
#include <HTTPClient.h>

static String baseUrl_g;
static String toJson(int deviceId, float roomTemperature, float bodyTemperature, String position, int32_t heartRate, int32_t spo2);

void HTTP_config(char *baseUrl)
{
  baseUrl_g = String(baseUrl);
}

void HTTP_deviceConnectWithServer(char *endpoint)
{
  if (WIFI_getStatus() == WL_CONNECTED)
  { //Check WiFi connection status

    HTTPClient http; //Declare object of class HTTPClient

    http.begin(baseUrl_g + endpoint);

    http.addHeader("Content-Type", "text/plain"); //Specify content-type header

    int httpCode = http.POST("");      //Send the request
    String payload = http.getString(); //Get the response payload

    Serial.println(httpCode); //Print HTTP return code
    Serial.println(payload);  //Print request response payload
    if (httpCode == -1)
    {
      Serial.print("Error in server connection");
    }
    http.end(); //Close connection
  }
  else
  {
    Serial.println("Error in wifi connection");
  }
}

void HTTP_sendSensorsData(char * endpoint, int deviceId ,float roomTemperature, float bodyTemperature, String position, int32_t heartRate, int32_t spo2)
{
  if (WIFI_getStatus() == WL_CONNECTED)
  {                  //Check WiFi connection status
    HTTPClient http; //Declare object of class HTTPClient

    http.begin(baseUrl_g + endpoint);

    http.addHeader("Content-Type", "text/plain"); //Specify content-type header
    String jsondata = toJson(deviceId, roomTemperature, bodyTemperature, position, heartRate, spo2);
    int httpCode = http.POST(jsondata); //Send the request
    String payload = http.getString();  //Get the response payload

    Serial.println(httpCode); //Print HTTP return code
    Serial.println(payload);  //Print request response payload

    http.end(); //Close connection
  }
  else
  {

    Serial.println("Error in WiFi connection");
  }
}


static String toJson(int deviceId, float roomTemperature, float bodyTemperature, String position, int32_t heartRate, int32_t spo2) {
  String jsonString = String(
               "{"
               "\"deviceId\":\"" + String(deviceId) + "\" ,"
               "\"tempRead\":\"" + String(roomTemperature) + "\","
               "\"babytempRead\": \"" + String(bodyTemperature) + "\","
               "\"heartrateRead\": \"" + String(heartRate) + "\","
               "\"spo2Read\":\"" + String(spo2) + "\","
               "\"positionRead\":\"" + position + "\"" "}"
             );
  return  jsonString;
}