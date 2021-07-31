#include "Timer.h"

#define TIMERS_NUM 4
void IRAM_ATTR onTimer0();
void IRAM_ATTR onTimer1();
void IRAM_ATTR onTimer2();
void IRAM_ATTR onTimer3();
typedef void (*Timer_ISR_Type)(void);
static hw_timer_t *timers[TIMERS_NUM];
static Timer_ISR_Type timersISR[TIMERS_NUM] = {onTimer0, onTimer1, onTimer2, onTimer3};
static VoidCallback timerCallbacks[TIMERS_NUM][NUM_CALLBACKS];

static portMUX_TYPE timersMux[TIMERS_NUM] = {portMUX_INITIALIZER_UNLOCKED, portMUX_INITIALIZER_UNLOCKED, portMUX_INITIALIZER_UNLOCKED, portMUX_INITIALIZER_UNLOCKED};
static unsigned char callbacksCount = 0;
static void callCallbacks(unsigned char timerId);

bool Timer_config(unsigned char timerId, uint32_t prescaler)
{
    if (timerId > TIMERS_NUM - 1)
    {
        return false;
    }
    timers[timerId] = timerBegin(timerId, prescaler, true);
    timerAttachInterrupt(timers[timerId], timersISR[timerId], true);
    timerAlarmWrite(timers[timerId], 8, true);
    int loop = 0;
    for (loop = 0; loop < NUM_CALLBACKS; loop++)
    {
        timerCallbacks[timerId][loop] = NULL;
    }
    return true;
}

bool Timer_configPeriodicDelay(unsigned char timerId, VoidCallback callback)
{
    if (callbacksCount > NUM_CALLBACKS - 1)
    {
        return false;
    }
    timerCallbacks[timerId][callbacksCount] = callback;
    callbacksCount++;
    return true;
}

bool Timer_start(unsigned char timerId)
{
    if (timerId > TIMERS_NUM - 1)
    {
        return false;
    }
    timerAlarmEnable(timers[timerId]);
    return true;
}

static void callCallbacks(unsigned char timerId)
{
    int loop = 0;
    for (loop = 0; loop < NUM_CALLBACKS; loop++)
    {
        if (timerCallbacks[timerId][loop] != NULL)
        {
            timerCallbacks[timerId][loop]();
        }
    }
}

void IRAM_ATTR onTimer0()
{
    portENTER_CRITICAL_ISR(&timersMux[0]);
    callCallbacks(0);
    portEXIT_CRITICAL_ISR(&timersMux[0]);
}

void IRAM_ATTR onTimer1()
{
    portENTER_CRITICAL_ISR(&timersMux[1]);
    callCallbacks(1);
    portEXIT_CRITICAL_ISR(&timersMux[1]);
}

void IRAM_ATTR onTimer2()
{
    portENTER_CRITICAL_ISR(&timersMux[2]);
    callCallbacks(2);
    portEXIT_CRITICAL_ISR(&timersMux[2]);
}

void IRAM_ATTR onTimer3()
{
    portENTER_CRITICAL_ISR(&timersMux[3]);
    callCallbacks(3);
    portEXIT_CRITICAL_ISR(&timersMux[3]);
}
