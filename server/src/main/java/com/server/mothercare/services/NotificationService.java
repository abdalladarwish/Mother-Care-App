package com.server.mothercare.services;

import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.Hashtable;

public interface NotificationService {
    public void notifyConnectedDevice(Long id, String message) throws IOException;

    public void addUser(Long userId, SseEmitter sseEmitter);

    public void removeUser(Long userId);
}
