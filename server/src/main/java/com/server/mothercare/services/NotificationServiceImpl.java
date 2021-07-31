package com.server.mothercare.services;

import com.server.mothercare.entities.User;
import com.server.mothercare.entities.kit.MonitoringDevice;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import javax.transaction.Transactional;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Hashtable;

@Service
@Slf4j
public class NotificationServiceImpl implements NotificationService{
    Hashtable<Long, SseEmitter> notificationList = new Hashtable<>();

    @Override
    public void notifyConnectedDevice(Long id, String message) throws IOException {
        if (this.notificationList.containsKey(id)){
            try{
                this.notificationList.get(id).send(message);
            } catch (IOException ioException){
                this.notificationList.get(id).complete();
            }
        }
    }

    @Override
    public void removeUser(Long userId){
        this.notificationList.remove(userId);
    }

    @Override
    public void addUser(Long userId, SseEmitter sseEmitter){
        this.notificationList.putIfAbsent(userId, sseEmitter);
    }
}
