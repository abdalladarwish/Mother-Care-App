package com.server.mothercare.services;

import com.server.mothercare.DAOs.DeviceDAO;
import com.server.mothercare.DAOs.UserDAO;
import com.server.mothercare.entities.BabyIssue;
import com.server.mothercare.entities.kit.*;
import com.server.mothercare.models.DeviceUsersSse;
import com.server.mothercare.models.kit.*;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.io.IOException;
import java.util.*;


@Service
@Slf4j
public class BabyMonitorServiceImpl implements BabyMonitorService{
    Hashtable<Long,List<DeviceUsersSse>> deviceUsers = new Hashtable<>();

    DeviceDAO deviceDAO;

    UserDAO userDAO;

    NotificationService notificationService;


    @Autowired
    BabyMonitorServiceImpl(DeviceDAO deviceDAO, UserDAO userDAO, NotificationService notificationService){
        this.deviceDAO = deviceDAO;
        this.userDAO = userDAO;
        this.notificationService = notificationService;
    }

    @Override
    public Hashtable<Long, List<DeviceUsersSse>> getEmitters() {
        return deviceUsers;
    }

    @Override
    @Transactional
    public void connectDevice(long id){
        this.deviceDAO.findById(id).ifPresentOrElse(device -> {
            this.deviceUsers.putIfAbsent(id, new ArrayList<>());
            try {
                log.info("loading...");
                this.notificationService.notifyConnectedDevice(device.getUser().getUserId(), "connected");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }, ()-> new Exception("This device is not found"));
    }

    @Override
    @Transactional
    public void disconnectDevice(long id){
        this.deviceDAO.findById(id).ifPresentOrElse(device -> {
            this.deviceUsers.remove(id);
            try {
                this.notificationService.notifyConnectedDevice(device.getUser().getUserId(), "disconnect");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }, ()-> new Exception("This device is not found"));
    }

    @Override
    @Transactional
    public int subscribeDevice(SseEmitter emitter, Long id){
        int connectedDevice = 0;
        Optional<MonitoringDevice> device = this.deviceDAO.findById(id);
        log.error("start subscribe");
        device.ifPresent(userDevice -> {
            log.error("user subscription");
            if(this.deviceUsers.containsKey(id)){
                log.error("user added to subscription list");
                String username = userDevice.getUser().getUsername();
                log.error(username +" :"+ id );
                this.deviceUsers.get(id).add(new DeviceUsersSse(username, emitter));
            }
        });
        if (device.isPresent())
        {
            connectedDevice = 1;
        }
        return connectedDevice;
    }

    @Override
    @Transactional
    public int unsubscribeDevice(Long id, String username) {
        int connectedDevice = 0;
        List<DeviceUsersSse> sseEmitterList = this.deviceUsers.get(id);
        sseEmitterList.removeIf(deviceUsersSse -> deviceUsersSse.getUsername().equals(username));
        log.error("device disconnected");
        return connectedDevice;
    }


    @Override
    @Transactional
    public void saveSensorRead(JSONObject json){
        Long id = json.getLong("deviceId");
        this.deviceDAO.findById(id).ifPresentOrElse(device -> {
            log.error("device in database");
            this.deviceUsers.putIfAbsent(id, new ArrayList<>());
            var users = this.deviceUsers.get(id);
            if (users.size() > 0){
                log.error("user found");
                var username = users.get(0).getUsername();
                var optionalUser = this.userDAO.getUserbyUserName(username);
                optionalUser.ifPresent(user1 -> {
                    log.error("got the user");
                    boolean issueFlag = false;
                    var babyIssues = user1.getBabyIssues();
                    TempRead tempRead = new TempRead(json.getDouble("tempRead"), new Date());
                    String positionRead = json.getString("positionRead");
                    HeartRateRead heartRateRead = new HeartRateRead(json.getDouble("heartrateRead"), new Date());
                    SPO2Read spo2Read = new SPO2Read(json.getDouble("spo2Read"), new Date());
                    SensorsReads sensorsReads = new SensorsReads(tempRead, spo2Read, heartRateRead, positionRead);
                    var spo2Reads = device.getSpo2Reads();
                    Collections.sort(spo2Reads);
                    var heartrateReads = device.getHeartRateReads();
                    Collections.sort(heartrateReads);
                    var tempReads = device.getTempReads();
                    Collections.sort(tempReads);
                    tempReads.add(tempRead);
                    heartrateReads.add(heartRateRead);
                    spo2Reads.add(spo2Read);
                    if (36.1 > tempRead.getValue() || tempRead.getValue() > 37.9){
                        log.error("temp not in range");
                        issueFlag = true;
                        if (tempReads.size() > 5){
                            log.error("temp array more than 5");
                            for (int i = (tempReads.size() -1); i > (tempReads.size() - 4); i--){
                                var temp = tempReads.get(i).getValue();
                                log.error("temp value : " + String.valueOf(temp));
                                if (36.1 < temp && temp < 37.9){
                                    issueFlag = false;
                                    device.setTempIssueFlag(false);
                                    log.error("no problem");
                                }
                            }
                            if (issueFlag == true && (device.isTempIssueFlag() == false)){
                                log.error("notify user issue");
                                device.setTempIssueFlag(true);
                                var issue = new BabyIssue("Something wrong with temperature",
                                        new SensorRead(tempRead.getValue(), tempRead.getTime()), device.getBabyName());
                                babyIssues.add(issue);
                                this.notifyWithBabyIssue(user1.getUserId(), "issue," + device.getBabyName());
                            }
                        }
                    }
                    if (70 > heartRateRead.getValue() || 160 < heartRateRead.getValue()){
                        issueFlag = true;
                        if (heartrateReads.size() > 5){
                            for (int i = (heartrateReads.size() -1); i > (heartrateReads.size() - 4); i--){
                                var temp = heartrateReads.get(i).getValue();
                                if (70 < temp || 160 > temp){
                                    issueFlag = false;
                                    device.setHeartrateIssueFlag(false);
                                }
                            }
                            if (issueFlag == true && (device.isHeartrateIssueFlag() == false)){
                                device.setHeartrateIssueFlag(true);
                                var issue = new BabyIssue("Something wrong with heart rate",
                                        new SensorRead(heartRateRead.getValue(), heartRateRead.getTime()), device.getBabyName());
                                babyIssues.add(issue);
                                this.notifyWithBabyIssue(user1.getUserId(), "issue," + device.getBabyName());
                            }
                        }
                    }
                    if (spo2Read.getValue() < 97){
                        issueFlag = true;
                        if (spo2Reads.size() > 5){
                            for (int i = (spo2Reads.size() -1); i > (spo2Reads.size() - 4); i--){
                                var temp = spo2Reads.get(i).getValue();
                                if (temp > 97){
                                    issueFlag = false;
                                    device.setSpo2IssueFlag(false);
                                }
                            }
                            if (issueFlag == true && (device.isSpo2IssueFlag() == false)){
                                device.setSpo2IssueFlag(true);
                                var issue = new BabyIssue("Something wrong with blood oxygen",
                                        new SensorRead(spo2Read.getValue(), spo2Read.getTime()), device.getBabyName());
                                babyIssues.add(issue);
                                this.notifyWithBabyIssue(user1.getUserId(), "issue," + device.getBabyName());
                            }
                        }
                    }
                    deviceDAO.save(device);
                    userDAO.save(user1);
                    this.notifyOnlineUser(id, sensorsReads);
                });
            }
        }, ()-> new Exception("This device is not found"));
    }

    private void notifyWithBabyIssue(Long userId, String message){
        try {
            this.notificationService.notifyConnectedDevice(userId, message);
        } catch (IOException e) { }
    }

    private void notifyOnlineUser(Long id, SensorsReads sensorsReads){
        for (DeviceUsersSse deviceUsersSse: deviceUsers.get(id)) {
            try {
                deviceUsersSse.getUsername();
                deviceUsersSse.getEmitter().send(SseEmitter.event().data(sensorsReads));
            } catch (IOException e) {
                deviceUsersSse.getEmitter().complete();
            }
        }
    }

    @Override
    @Transactional
    public void addDevice(MonitoringDevice device){
        this.deviceDAO.save(device);
    }
}
