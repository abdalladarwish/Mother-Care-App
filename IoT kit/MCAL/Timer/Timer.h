#ifndef TIMER_H
#define TIMER_H
#include <Arduino.h>
#define NUM_CALLBACKS 2
typedef void(*VoidCallback)(void);
bool Timer_config(unsigned char timerId, uint32_t prescaler);

bool Timer_configPeriodicDelay(unsigned char timerId, VoidCallback callback);
bool Timer_start(unsigned char timerId);

#endif