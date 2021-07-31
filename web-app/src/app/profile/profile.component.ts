import {ChangeDetectorRef, Component, OnInit, ViewEncapsulation} from '@angular/core';
import {UserService} from '../services/user.service';
import {User} from '../models/user.model';
import {MatDialog} from '@angular/material/dialog';
import {AdditionalInfoComponent} from '../auth/additional-info/additional-info.component';
import {EventsService} from '../services/events.service';
import {Router} from '@angular/router';
import {TokenService} from '../services/Token.service';
import {EventModel} from '../models/event.model';
import {DeviceService} from '../services/device-service';
import {ListItemsComponent} from './list-items/list-items.component';
import {Subject} from 'rxjs';


@Component({
  selector: 'user-profile',
  templateUrl: './profile.component.html',
  styleUrls: ['./profile.component.css'],
  encapsulation: ViewEncapsulation.None
})
export class ProfileComponent implements  OnInit{
  mainPage = 'about';
  pregnancyAccomplishment = null;
  theUser: User;
  profileImg: any = '../../assets/images/newimg2.jpeg';
  message: string;
  imageName: any;
  tab = 0;
  upcomingEvents: EventModel[] = [];
  babyIssues: any = [];
  recentBabyIssues: any = [];

  constructor(public userService: UserService, private dialog: MatDialog, private eventService: EventsService,
              private tokenService: TokenService, private router: Router, private deviceService: DeviceService, private detector : ChangeDetectorRef)
  {}

  ngOnInit(): void {
    if (this.tokenService.getToken() == null){
      this.router.navigate(['/login']);
    } else {
      this.getUser();
      this.updateBabiesIssues();
      this.eventService.addedEvents.subscribe(data => {
        this.upcomingEvents = [...this.eventService.upcomingEvents];
      });
      this.deviceService.babiesIssues.subscribe(babyName => {
        this.deviceService.getLastIssue(babyName).subscribe(resp => {
          console.log(resp.body);
          resp.body.sensorRead.time = new Date(resp.body.sensorRead.time).toLocaleString();
          this.recentBabyIssues.unshift(resp.body);
          this.recentBabyIssues.splice(-1);
          this.recentBabyIssues = [...this.recentBabyIssues]
        });
      });
    }
  }


  updateProfileImg(event){
    if (!event.target.files[0] || event.target.files[0].length == 0) {
      return;
    }
    const mimeType = event.target.files[0].type;
    if (mimeType.match(/image\/*/) == null) {
      return;
    }
    const reader = new FileReader();
    reader.readAsDataURL(event.target.files[0]);
    this.userService.saveProfileImg(event.target.files[0]).subscribe((response) => {
        if (response.status === 200) {
          this.message = 'Image uploaded successfully';
        } else {
          this.message = 'Image not uploaded successfully';
        }
      }
    );
    reader.onload = (_event) => {
      this.profileImg = reader.result;
      this.userService.theUser.profileImg = this.profileImg;
    };
  }

  getUser(): void{
    this.userService.getUser().subscribe(resp => {
      this.userService.theUser = resp.body;
      this.userService.userReceived.next(true);
      this.theUser = this.userService.theUser;
      const pregnancyDate = this.userService.theUser.pregnancyDate;
      if (this.userService.theUser.additionalInfo == false){
        const dialogConfig = {
          autoFocus : true,
          disableClose : true
        };
        this.dialog.open(AdditionalInfoComponent, dialogConfig);
      }
      if (pregnancyDate != null){
        const currentDate = new Date();
        const dateOfPregnancy = new Date(pregnancyDate);
        const dateOfbirth = new Date(dateOfPregnancy.getTime() + 23328000000);
        const diff = Math.ceil(Math.abs((currentDate.getTime() - dateOfPregnancy.getTime()) / (1000 * 3600 * 24)));
        const diff2 = Math.ceil(Math.abs( (dateOfbirth.getTime() - dateOfPregnancy.getTime()) / (1000 * 3600 * 24)));
        this.pregnancyAccomplishment = Math.round((diff / diff2) * 100 * 100) / 100;
      }
    });
  }

  updateBabiesIssues(): void{
    this.deviceService.getBabiesIssues().subscribe(resp => {
      const issues: any = resp.body;
      this.babyIssues = [];
      for (const issue of issues){
        issue.sensorRead.time = new Date(issue.sensorRead.time).toLocaleString();
      }
      this.babyIssues = [...issues];
      this.updateRecentBabyIssues();
    });
  }

  showList(listName: string): void{
    let dialogConfig = null;
    if (listName === 'events'){
      dialogConfig = {
        autoFocus : true,
        data : {
          type : listName,
          list : this.eventService.upcomingEvents
        }
      };
    } else {
      dialogConfig = {
        autoFocus : true,
        data : {
          type : listName,
          list : this.babyIssues
        }
      };
    }
    this.dialog.open(ListItemsComponent, dialogConfig);
  }

  updateRecentBabyIssues(): void{
    this.babyIssues.sort((o1, o2) => {
      if (o1.sensorRead.time > o2.sensorRead.time) {    return -1; }
      else if (o1.sensorRead.time < o2.sensorRead.time) { return  1; }
      else { return  0; }
    });
    this.babyIssues
    this.babyIssues = [...this.babyIssues]
    this.recentBabyIssues = [];
    this.recentBabyIssues = [...this.babyIssues.slice(0, 4)];
    this.detector.detectChanges();
  }
}
