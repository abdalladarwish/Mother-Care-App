package com.server.mothercare.services;

import com.server.mothercare.entities.Event;
import com.server.mothercare.entities.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class EventServiceImpl implements EventService{
    private UserService userService;

    @Autowired
    public EventServiceImpl(UserService userService){
        this.userService = userService;
    }

    @Override
    public List<Event> getEvents(Principal user) {
        Optional<User> optionalUser = this.userService.getUserbyUserName(user.getName());
        User theUser = optionalUser.get();
        List<Event> eventsList = theUser.getEvents();
        return eventsList;
    }

    @Override
    public Event addEvent(Event event, Principal user) {
        Optional<User> optionalUser = this.userService.getUserbyUserName(user.getName());
        optionalUser.ifPresent(user1 ->{
            user1.numOfEvents++;
            event.setId(user1.numOfEvents);
            user1.getEvents().add(event);
            this.userService.update(user1);
        });
        return event;
    }

    @Override
    public Event editEvent(Event event, Principal user) {
        Optional<User> optionalUser = this.userService.getUserbyUserName(user.getName());
        optionalUser.ifPresent(user1 ->{
            for (var e :
                    user1.getEvents()) {
                if (e.getId() == event.getId()){
                    e.setTitle(event.getTitle());
                    e.setReminder(event.isReminder());
                    e.setPrimaryColor(event.getPrimaryColor());
                    e.setSecondaryColor(event.getSecondaryColor());
                    e.setTitle(event.getTitle());
                    e.setStartDate(event.getStartDate());
                    e.setEndDate(event.getEndDate());
                    e.setDescription(event.getDescription());
                    e.setImage(event.getImage());
                }
            }
            this.userService.update(user1);
        });
        return event;
    }

    @Override
    public boolean deleteEvent(Long eventId, Principal user) {
        boolean result = false;
        Optional<User> optionalUser = this.userService.getUserbyUserName(user.getName());
        User user1 = optionalUser.get();
        if (user1 != null){
            var events = user1.getEvents();
            events.removeIf(event -> event.getId() == Long.valueOf(eventId));
            this.userService.update(user1);
            result = true;
        }
        return result;
    }
}
