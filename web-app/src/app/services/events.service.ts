import {CalendarEvent} from 'angular-calendar';
import {Injectable} from '@angular/core';
import {Observable, Subject, Subscription} from 'rxjs';
import {FormControl, FormGroup} from '@angular/forms';
import {HttpClient} from '@angular/common/http';
import {map} from 'rxjs/operators';
import {EventModel} from '../models/event.model';
import {TokenService} from './Token.service';




@Injectable({
  providedIn : 'root'
})
export class EventsService{
  form: FormGroup = new FormGroup({
    title : new FormControl(null),
    primaryColor : new FormControl(''),
    secondaryColor : new FormControl(''),
    start : new FormControl(''),
    end : new FormControl(null),
  });

  events: EventModel[] = [];

  eventsCalendar: CalendarEvent[] = [];

  upcomingEvents: EventModel[] = [];


  color = {primary: '', secondary: ''};

  constructor(private http: HttpClient, private tokenService: TokenService) {
  }

  event: EventModel = new EventModel();

  addedEvents = new Subject<boolean>();

  getEvents(): Observable<any>{
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    return this.http.get('http://localhost:8080/events', {observe: 'response', headers}).pipe(map((resp) => {
      const eventList: any = resp.body;
      this.events = [];
      this.eventsCalendar = [];
      for (const event of eventList) {
        const eventColor = {
          primary: event.primaryColor, secondary: event.secondaryColor
        };
        const savedEvent: CalendarEvent = {
          color: eventColor, draggable: true, end: new Date(event.endDate), id: event.id,
          start: new Date(event.startDate), title: event.title
        };
        this.events.push(event);
        this.eventsCalendar.push(savedEvent);
      }
      this.updateUpcomingEvents();
      this.addedEvents.next(true);
      return this.eventsCalendar;
    })
    );
  }

  addEvent(event: EventModel, reminder: string): Subscription{
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    reminder === 'yes' ? event.reminder = true : event.reminder = false;
    return this.http.post('http://localhost:8080/event', event, {observe: 'response', headers}).subscribe(resData => {
      const addedEvent: any = resData.body;
      const eventColor = {
        primary: addedEvent.primaryColor, secondary: addedEvent.secondaryColor
      };
      const savedEvent: CalendarEvent = {
        color: eventColor, draggable: true, end: new Date(addedEvent.endDate), id: addedEvent.id,
        start: new Date(addedEvent.startDate), title: addedEvent.title
      };
      event.id = addedEvent.id;
      this.events.push(event);
      this.eventsCalendar.push(savedEvent);
      this.updateUpcomingEvents();
      this.addedEvents.next(true);
    });
  }

  editEvent(event: EventModel, reminder: string): Subscription{
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    reminder === 'yes' ? event.reminder = true : event.reminder = false;
    return this.http.put('http://localhost:8080/event', event, {observe: 'response', headers}).subscribe(resData => {
      const editedEvent: any = resData.body;
      const index = this.events.findIndex(event1 => event1.id === editedEvent.id);
      this.events[index] = event;
      const eventColor = {
        primary: editedEvent.primaryColor, secondary: editedEvent.secondaryColor
      };
      const savedEvent: CalendarEvent = {
        color: eventColor, draggable: true, end: new Date(editedEvent.endDate), id: editedEvent.id,
        start: new Date(editedEvent.startDate), title: editedEvent.title
      };
      this.eventsCalendar[index] = savedEvent;
      this.updateUpcomingEvents();
      this.addedEvents.next(true);
    });
  }

  deleteEvent(eventId: number): Subscription{
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    return this.http.delete('http://localhost:8080/event/' + eventId, {observe: 'response', headers}).subscribe(() => {
      const index = this.events.findIndex(oldEvent => oldEvent.id === eventId);
      this.events.splice(index, 1);
      this.eventsCalendar.splice(index, 1);
      this.updateUpcomingEvents();
      this.addedEvents.next(true);
    });
  }

  populateEvent(event): void{
    this.event.id = event.id;
    this.event.title = event.title;
    this.color.primary = event.color.primary;
    this.color.secondary = event.color.secondary;
    this.event.startDate = event.start;
    this.event.endDate = event.end;
    const index = this.events.findIndex(event1 => event1.id === event.id);
    console.log(this.events);
    console.log(this.upcomingEvents);
    this.event.description = this.events[index].description;
    this.event.image = this.events[index].image;
  }

  updateUpcomingEvents(): void{
    const events = [...this.events];
    events.sort((o1, o2) => {
      if (o1.startDate < o2.startDate) {    return -1; }
      else if (o1.startDate > o2.startDate) { return  1; }
      else { return  0; }
    });
    const nowDate = new Date();
    this.upcomingEvents = [];
    for (const event of events){
      const eventDate = new Date(event.startDate);
      if (eventDate >= nowDate){
        event.startDate = new Date(event.startDate).toLocaleString();
        event.endDate = new Date(event.endDate).toLocaleString();
        this.upcomingEvents.push(event);
      }
      if (this.upcomingEvents.length > 3){
        break;
      }
    }
  }

  addMonths(date, months): Date {
    const d = date.getDate();
    date.setMonth(date.getMonth() + +months);
    if (date.getDate() !== d) {
      date.setDate(0);
    }
    return date;
  }

}
