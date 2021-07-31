#include <OneWire.h>
#include <DallasTemperature.h>

// GPIO where the DS18B20 is connected to
static const int oneWireBus = 4;

// Setup a oneWire instance to communicate with any OneWire devices
static OneWire oneWire(oneWireBus);

// Pass our oneWire reference to Dallas Temperature sensor
static DallasTemperature sensors(&oneWire);

float getBodyTemperature(void)
{
    sensors.requestTemperatures();
    return sensors.getTempCByIndex(0);
}