package com.server.mothercare.rest.event;

import com.server.mothercare.entities.Event;
import com.server.mothercare.entities.User;
import com.server.mothercare.services.EventService;
import com.server.mothercare.services.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

@Controller
@Slf4j
public class EventController {

    UserService userService;
    EventService eventService;

    @Autowired
    public EventController(UserService userService, EventService eventService)
    {
        this.userService = userService;
        this.eventService = eventService;
    }

    @GetMapping("/events")
    public ResponseEntity getUserEvents(Principal user){
       var eventsList = eventService.getEvents(user);
       return new ResponseEntity(eventsList, HttpStatus.OK);
    }

    @PostMapping("/event")
    public ResponseEntity addEvent(@RequestBody Event event, Principal user){
       var newEvent = this.eventService.addEvent(event, user);
        return new ResponseEntity(newEvent, HttpStatus.OK);
    }

    @PutMapping("/event")
    public ResponseEntity editEvent(@RequestBody Event event, Principal user){
        var editedEvent = this.eventService.editEvent(event, user);
        return new ResponseEntity(editedEvent, HttpStatus.OK);
    }

    @DeleteMapping("/event/{eventId}")
    public ResponseEntity deleteEvent(@PathVariable String eventId, Principal user){
        Long id = Long.valueOf(eventId);
        boolean result = this.eventService.deleteEvent(id, user);
        ResponseEntity responseEntity = null;
        if (result == true){
            responseEntity = new ResponseEntity(HttpStatus.OK);
        } else {
            responseEntity = new ResponseEntity(HttpStatus.CONFLICT);
        }
        return responseEntity;
    }
}
