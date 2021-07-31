package com.server.mothercare.services;

import com.server.mothercare.entities.Event;

import java.security.Principal;
import java.util.List;

public interface EventService {
    public List<Event> getEvents(Principal user);

    public Event addEvent(Event event, Principal user);

    public Event editEvent(Event event, Principal user);

    public boolean deleteEvent(Long eventId, Principal user);
}
