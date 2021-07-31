package com.server.mothercare.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.security.PrivateKey;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;

@Data
@AllArgsConstructor
public class DeviceUsersSse {
    private String username;
    private SseEmitter emitter;
}
