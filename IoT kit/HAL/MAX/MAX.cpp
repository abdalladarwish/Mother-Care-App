#include "MAX.h"
#include <Wire.h>
#include "spo2_algorithm.h"

#if defined(__AVR_ATmega328P__) || defined(__AVR_ATmega168__)
//Arduino Uno doesn't have enough SRAM to store 100 samples of IR led data and red led data in 32-bit format
//To solve this problem, 16-bit MSB of the sampled data will be truncated. Samples become 16-bit data.
uint16_t irBuffer[100];  //infrared LED sensor data
uint16_t redBuffer[100]; //red LED sensor data
#else
uint32_t irBuffer[100];  //infrared LED sensor data
uint32_t redBuffer[100]; //red LED sensor data
#endif

int32_t spo2;          //SPO2 value
int8_t validSPO2;      //indicator to show if the SPO2 calculation is valid
int32_t _heartRate;     //heart rate value
int8_t validHeartRate; //indicator to show if the heart rate calculation is valid

static MAX30105 maxSensor;

bool isFirstTimeGettingData = true;

bool MAX_checkExistance(void)
{
    if (!maxSensor.begin(Wire, 0x57))
    {
        Serial.println("MAX30105 was not found. Please check wiring/power. ");
        return false;
    }
    return true;
}

void MAX_config(unsigned char powerLevel, unsigned char sampleAverage, unsigned char ledMode, int sampleRate, int pulseWidth, int adcRange)
{
    maxSensor.setup(powerLevel, sampleAverage, ledMode, sampleRate, powerLevel, adcRange);
}

bool MAX_getSPO2Value(int32_t *spo2Value)
{
    *spo2Value = spo2;
    return validSPO2;
}

bool MAX_getHeartRateValue(int32_t *heartRate)
{
    *heartRate = _heartRate;
    return validHeartRate;
}

void MAX_getSPO2AndHeartRate(void)
{
    if (isFirstTimeGettingData)
    {

        //read the first 100 samples, and determine the signal range
        for (byte i = 0; i < MAX_BUFFER_DATA_SIZE; i++)
        {
            while (maxSensor.available() == false) //do we have new data?
                maxSensor.check();                 //Check the sensor for new data

            redBuffer[i] = maxSensor.getRed();
            irBuffer[i] = maxSensor.getIR();
            maxSensor.nextSample(); //We're finished with this sample so move to next sample

            Serial.print(F("red="));
            Serial.print(redBuffer[i], DEC);
            Serial.print(F(", ir="));
            Serial.println(irBuffer[i], DEC);
        }

        //calculate heart rate and SpO2 after first 100 samples (first 4 seconds of samples)
        maxim_heart_rate_and_oxygen_saturation(irBuffer, MAX_BUFFER_DATA_SIZE, redBuffer, &spo2, &validSPO2, &_heartRate, &validHeartRate);
        isFirstTimeGettingData = false;
    }
    else
    {
        //dumping the first 25 sets of samples in the memory and shift the last 75 sets of samples to the top
        for (byte i = 25; i < MAX_BUFFER_DATA_SIZE; i++)
        {
            redBuffer[i - 25] = redBuffer[i];
            irBuffer[i - 25] = irBuffer[i];
        }

        //take 25 sets of samples before calculating the heart rate.
        for (byte i = 75; i < MAX_BUFFER_DATA_SIZE; i++)
        {
            while (maxSensor.available() == false) //do we have new data?
                maxSensor.check();                 //Check the sensor for new data
                
            redBuffer[i] = maxSensor.getRed();
            irBuffer[i] = maxSensor.getIR();
            maxSensor.nextSample(); //We're finished with this sample so move to next sample

            //send samples and calculation result to terminal program through UART
            Serial.print(F("red="));
            Serial.print(redBuffer[i], DEC);
            Serial.print(F(", ir="));
            Serial.print(irBuffer[i], DEC);

            Serial.print(F(", HR="));
            Serial.print(_heartRate, DEC);

            Serial.print(F(", HRvalid="));
            Serial.print(validHeartRate, DEC);

            Serial.print(F(", SPO2="));
            Serial.print(spo2, DEC);

            Serial.print(F(", SPO2Valid="));
            Serial.println(validSPO2, DEC);
        }

        //After gathering 25 new samples recalculate HR and SP02
        maxim_heart_rate_and_oxygen_saturation(irBuffer, MAX_BUFFER_DATA_SIZE, redBuffer, &spo2, &validSPO2, &_heartRate, &validHeartRate);
    }
}
