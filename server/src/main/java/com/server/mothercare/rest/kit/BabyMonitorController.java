package com.server.mothercare.rest.kit;


import com.server.mothercare.entities.BabyIssue;
import com.server.mothercare.entities.User;
import com.server.mothercare.models.DeviceUsersSse;
import com.server.mothercare.entities.kit.MonitoringDevice;
import com.server.mothercare.services.BabyMonitorService;
import com.server.mothercare.services.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.security.Principal;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import org.json.*;

@RestController
@Slf4j
public class BabyMonitorController {

    BabyMonitorService babyMonitorService;
    UserService userService;

    @Autowired
    BabyMonitorController(BabyMonitorService babyMonitorService, UserService userService){
        this.babyMonitorService = babyMonitorService;
        this.userService = userService;
    }

    /* Device send to this endpoint to connect to server*/
    @PostMapping("device/{deviceId}/connection")
    public void connectDevice(@PathVariable String deviceId){
        Long id = Long.valueOf(deviceId);
        log.info("connect device : " + id);
        this.babyMonitorService.connectDevice(id);
    }


    /* Device send to this endpoint to disconnect with server */
    @PostMapping("device/{deviceId}/disconnection")
    public void disconnectDevice(@PathVariable String deviceId){
        Long id = Long.valueOf(deviceId);
        this.babyMonitorService.disconnectDevice(id);
    }

    /* Client send to this endpoint to subscribe to a device with exact id */
    @GetMapping("device/{deviceId}/subscription")
    public SseEmitter subscribe(@PathVariable String deviceId){
        log.error(deviceId);
        var id = Long.valueOf(deviceId);
        SseEmitter sseEmitter = new SseEmitter(-1L);
        var result = this.babyMonitorService.subscribeDevice(sseEmitter, id);
        sseEmitter.onCompletion(() -> {
            List<DeviceUsersSse> subscribers = this.babyMonitorService.getEmitters().get(id);
            subscribers.remove(sseEmitter);
        });
        sseEmitter.onError((error) -> {
            sseEmitter.complete();
        });
        return sseEmitter;
    }

    @GetMapping("device/{deviceId}/unsubscription")
    public ResponseEntity unsubscribe(@PathVariable String deviceId, Principal user){
        log.error(deviceId);
        var id = Long.valueOf(deviceId);
        var result = this.babyMonitorService.unsubscribeDevice(id, user.getName());
        return new ResponseEntity(HttpStatus.OK);
    }

    /* Device send to this endpoint to send sensors data to its subscribers */
    @PostMapping("device/data")
    public void sendData(@RequestBody String data){
        log.error(data);
        JSONObject json = new JSONObject(data);
        this.babyMonitorService.saveSensorRead(json);
    }

    @GetMapping("/devices")
    public ResponseEntity getUserDevices(Principal user){
        var todayDate = new Date();
        var msecToDay = 1 / (60 * 60 * 1000 * 24);
        Optional<User> optionalUser = this.userService.getUserbyUserName(user.getName());
        User theUser = optionalUser.get();
        List<MonitoringDevice> monitoringDeviceList = theUser.getDevices();
        for (MonitoringDevice device :
                monitoringDeviceList) {
            device.getTempReads().stream().filter(tempRead -> (tempRead.getTime().getTime() * msecToDay) == (todayDate.getTime() * msecToDay));
            device.getHeartRateReads().stream().filter(heartRateRead -> (heartRateRead.getTime().getTime() * msecToDay) == (todayDate.getTime() * msecToDay));
            device.getSpo2Reads().stream().filter(spo2Read -> (spo2Read.getTime().getTime() * msecToDay) == (todayDate.getTime() * msecToDay));
            Collections.sort(device.getHeartRateReads());
            Collections.sort(device.getTempReads());
            Collections.sort(device.getSpo2Reads());
        }
        return new ResponseEntity(monitoringDeviceList, HttpStatus.OK);
    }



    @PostMapping("/device")
    public ResponseEntity addDevice(@RequestBody String  jsonString, Principal user){
        JSONObject jsonObject = new JSONObject(jsonString);
        long deviceId = Long.valueOf(jsonObject.getLong("deviceId"));
        String babyName = jsonObject.getString("babyName");
        MonitoringDevice monitoringDevice = new MonitoringDevice();
        monitoringDevice.setDeviceId(deviceId);
        monitoringDevice.setBabyName(babyName);
        Optional<User> optionalUser = this.userService.getUserbyUserName(user.getName());
        optionalUser.ifPresent(user1 ->{
            monitoringDevice.setUser(user1);
            monitoringDevice.setTempIssueFlag(false);
            monitoringDevice.setHeartrateIssueFlag(false);
            monitoringDevice.setSpo2IssueFlag(false);
            user1.getDevices().add(monitoringDevice);
            this.babyMonitorService.addDevice(monitoringDevice);
        });
        return new ResponseEntity(HttpStatus.OK);
    }

    @GetMapping("/babies/issues")
    public ResponseEntity getBabiesIssues(Principal user){
        Optional<User> optionalUser = this.userService.getUserbyUserName(user.getName());
        ResponseEntity responseEntity = null;
        var resultUser = optionalUser.get();
        if (user != null){
            responseEntity = new ResponseEntity(resultUser.getBabyIssues(), HttpStatus.OK);
        } else {
            responseEntity = new ResponseEntity(HttpStatus.CONFLICT);
        }
        return responseEntity;
    }

    @GetMapping("/last/issue/{babyname}")
    public BabyIssue getLastBabyIssue(Principal principal, @PathVariable String babyname){
        String username = principal.getName();
        var user = this.userService.getUserbyUserName(username);
        var issues = user.get().getBabyIssues().stream()
                .filter(issue -> issue.getBabyName().equals(babyname))
                .map(issue-> new BabyIssue(issue.getDescription(), issue.getSensorRead(), issue.getBabyName()))
                .collect(Collectors.toList());
        log.warn(issues.toString());
        log.warn("list size : " + String.valueOf(issues.size()));
        Collections.sort(issues);
        log.warn(issues.toString());
        return issues.get(issues.size() - 1);
    }
}
