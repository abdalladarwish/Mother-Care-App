package com.server.mothercare.services;

import com.server.mothercare.models.DeviceUsersSse;
import com.server.mothercare.entities.kit.MonitoringDevice;
import org.json.JSONObject;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.Hashtable;
import java.util.List;

public interface BabyMonitorService {

    public Hashtable<Long, List<DeviceUsersSse>> getEmitters();

    public void connectDevice(long id);

    public void disconnectDevice(long id);

    public int subscribeDevice(SseEmitter emitter, Long id);

    public int unsubscribeDevice(Long id, String username);

    public void saveSensorRead(JSONObject json);

    public void addDevice(MonitoringDevice device);
}
