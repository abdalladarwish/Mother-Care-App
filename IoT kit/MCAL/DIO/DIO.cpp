#ifndef DIO_H
#define DIO_H
#include "DIO.h"
#include <Arduino.h>
bool Dio_channelDir(unsigned char channelId, unsigned char dir)
{
    if (channelId > 14 || dir > 1)
    {
        return false;
    }
    pinMode(channelId, dir);
    return true;
}

bool Dio_channelWrite(unsigned char channelId, unsigned char data)
{
    if (channelId > 14 || data > 1)
    {
        return false;
    }
    digitalWrite(channelId, data);
    return true;
}

bool Dio_channelRead(unsigned char channelId, unsigned char *data)
{
    if (channelId > 14)
    {
        return false;
    }
    *data = digitalRead(channelId);
    return true;
}
#endif 