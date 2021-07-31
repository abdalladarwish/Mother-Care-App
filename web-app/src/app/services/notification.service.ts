import {Injectable} from "@angular/core";
import {Observable, Subject} from 'rxjs';
import {UserService} from "./user.service";

@Injectable({
  providedIn : "root"
})
export class NotificationService{
  notification: Subject<any>;

  constructor(private userService: UserService) {
    this.notification = new Subject();
  }

  subscribeForNotification() {
    console.log("subscribe");
      const eventSource = new EventSource('http://localhost:8080/notifier/' + this.userService.theUser.username);
      eventSource.onmessage = event => {
        this.notification.next(event.data);
        console.log("recieve notification");
      };
      eventSource.onerror = error => {
        eventSource.close();
        this.subscribeForNotification();
      };
  }

}
