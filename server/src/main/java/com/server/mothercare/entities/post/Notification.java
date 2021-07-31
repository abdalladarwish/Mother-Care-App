package com.server.mothercare.entities.post;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@Builder
public class Notification {
//    private User user;
    private Object message;
    private String entityType;
    private String operation;
    @Builder.Default
    private LocalDateTime localDateTime = LocalDateTime.now();
}