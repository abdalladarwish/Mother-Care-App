import {Component, Inject, OnInit} from '@angular/core';
import {Subject} from 'rxjs';
import {EventsService} from '../../../services/events.service';
import {addDays, endOfMonth, subDays} from 'date-fns';
import {CalendarEvent} from 'angular-calendar';
import {MAT_DIALOG_DATA, MatDialogRef} from '@angular/material/dialog';
import {EventModel} from '../../../models/event.model';

@Component({
  selector: 'app-event-choice',
  templateUrl: './event-choice.component.html',
  styleUrls: ['./event-choice.component.css']
})
export class EventChoiceComponent implements OnInit {
  date = new Date();
  event: EventModel = new EventModel();
  actionType: string;
  reminder = 'no';

  constructor(public eventsService: EventsService,  public dialogRef: MatDialogRef<EventChoiceComponent>, @Inject(MAT_DIALOG_DATA) public data: any) {}

  ngOnInit(): void {
    if (this.data.num == 'add'){
      this.resetEvent();
    } else {
      this.event.startDate = this.eventsService.event.startDate;
      this.event.endDate = this.eventsService.event.endDate;
      this.event.id = +this.eventsService.event.id;
      this.event.title = this.eventsService.event.title;
      this.event.primaryColor = this.eventsService.event.primaryColor;
      this.event.secondaryColor = this.eventsService.event.secondaryColor;
      this.event.reminder = this.eventsService.event.reminder;
      this.event.description = this.eventsService.event.description;
      this.event.image = this.eventsService.event.image;
    }
    this.actionType = this.data.num;
  }


  addEvent(){
    console.log('add event : ' + this.event.title);
    this.eventsService.addEvent(this.event, this.reminder);
    this.onClose();
  }

  editEvent(){
    this.eventsService.editEvent(this.event, this.reminder);
    this.onClose();
  }

  deleteEvent(){
    this.eventsService.deleteEvent(+this.event.id);
    this.onClose();
  }

  onClose(){
    this.dialogRef.close();
    this.resetEvent();
  }

  resetEvent(){
    this.eventsService.event.title = '';
    this.eventsService.event.startDate = new Date().toLocaleString();
    this.eventsService.event.endDate = new Date().toLocaleString();
    this.eventsService.event.primaryColor = '';
    this.eventsService.event.secondaryColor = '';
    this.eventsService.event.description = '';
    this.eventsService.event.image = null;
  }
}
