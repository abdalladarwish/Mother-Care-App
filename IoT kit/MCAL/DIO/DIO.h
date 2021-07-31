#ifndef DIO_H
#define DIO_H

bool DIO_channelDir(unsigned char channelId, unsigned char dir);

bool DIO_channelWrite(unsigned char channelId, unsigned char data);

bool DIO_channelRead(unsigned char channelId, unsigned char *data);
#endif
