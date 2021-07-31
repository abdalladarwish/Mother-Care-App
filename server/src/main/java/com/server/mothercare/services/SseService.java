package com.server.mothercare.services;

import com.server.mothercare.entities.post.Notification;
import lombok.Data;
import org.springframework.stereotype.Service;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CopyOnWriteArrayList;

@Service
@Data
public class SseService {

    // Save all emitters from different connections, to send message to all
    private final CopyOnWriteArrayList<SseEmitter> emitters = new CopyOnWriteArrayList<>();

    public SseEmitter registerClient() {
        SseEmitter emitter = new SseEmitter();

        // Add client specific new emitter in global list
        emitters.add(emitter);

        // On Client connection completion, unregister client specific emitter
        emitter.onCompletion(() -> emitters.remove(emitter));

        // On Client connection timeout, unregister and mark complete client specific emitter
        emitter.onTimeout(() -> {
            emitter.complete();
            emitters.remove(emitter);
        });
        return emitter;
    }

    public void process(Object message, String entityType, String operation)  {

        Notification notification = Notification.builder()
                .message(message)
                .entityType(entityType )
                .operation(operation)
                .build();

        sendEventToClients(notification);
    }

    public void sendEventToClients(Object notification) {
        // Track which events could not be sent
        List<SseEmitter> deadEmitters = new ArrayList<>();
        // Send to all registered clients
        emitters.forEach(emitter -> {
            try {
                emitter.send(notification);
            } catch (Exception e) {
                // record failed ones
                deadEmitters.add(emitter);
            }
        });
        // remove the failed one, otherwise it will keep on waiting for client connection
        emitters.remove(deadEmitters);
    }
}