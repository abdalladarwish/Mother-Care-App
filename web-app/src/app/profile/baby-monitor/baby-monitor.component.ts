import {ChangeDetectorRef, Component, NgZone, OnInit, ViewChild, ViewChildren} from '@angular/core';
import {MatDialog, MatDialogConfig} from '@angular/material/dialog';
import {TempChartComponent} from './temp-chart/temp-chart.component';
import {HeartRateChartComponent} from './heart-rate-chart/heart-rate-chart.component';
import {RespirChartComponent} from './respir-chart/respir-chart.component';
import {DeviceService} from '../../services/device-service';
import {Observable, Subscription} from 'rxjs';
import {NotificationService} from '../../services/notification.service';
import {DeviceModel} from '../../models/device.model';
import {copyArrayItem} from '@angular/cdk/drag-drop';
import {AdditionalInfoComponent} from '../../auth/additional-info/additional-info.component';
import {UserService} from '../../services/user.service';
import {MatSnackBar} from '@angular/material/snack-bar';

@Component({
  selector: 'baby-monitor',
  templateUrl: './baby-monitor.component.html',
  styleUrls: ['./baby-monitor.component.css']
  })
export class BabyMonitorComponent implements OnInit {
  subscriptions: Subscription[] = [];
  devices: DeviceModel[] = [];
  positions: any = {'R' : '../../../assets/images/right.jpeg', 'L' : '../../../assets/images/left.jpeg', 'F' : 'l../../../assets/images/front.jpeg', 'B' : '../../../assets/images/back.jpeg', 'Undefined' : ''};
  currentReads: {tempRead : number, heartrateRead: number, spo2Read: number, positionRead: string}[] = [];
  tempReads: number[] = []
  positionReads: string[] = []
  heartrateReads: number[] = []
  spo2Reads: number[] = []


  constructor(private dialog: MatDialog, private  sensorService: DeviceService, private notificationService: NotificationService,
              public zone: NgZone, private userService: UserService, private detector: ChangeDetectorRef, private snackBar: MatSnackBar) {}

  ngOnInit(): void{
    this.getDevices();
    this.notificationService.subscribeForNotification();
    this.notificationService.notification.subscribe(data => this.handleNotifications(data));
    this.sensorService.devicesArrived.subscribe(() => this.subscribeForDevices());
    this.sensorService.sensorSent.subscribe(num => {
      let tempReads = this.sensorService.monitoringDevices[num].tempReads.tempRead;
      let spo2Reads = this.sensorService.monitoringDevices[num].spo2Reads.spo2Read;
      let heartrateReads = this.sensorService.monitoringDevices[num].heartRateReads.heartRateRead;
      this.tempReads[num] = tempReads[tempReads.length - 1];
      this.spo2Reads[num] = spo2Reads[spo2Reads.length - 1];
      this.heartrateReads[num] = heartrateReads[heartrateReads.length - 1];
      this.tempReads = [...this.tempReads];
      this.spo2Reads = [...this.spo2Reads];
      this.heartrateReads = [...this.heartrateReads];
      this.positionReads[num] = this.sensorService.monitoringDevices[num].positionRead;
      this.detector.detectChanges();
    })
    for (let eventSource of this.sensorService.devicesEventSources){
      eventSource.onerror = error => {
        this.getDevices();
      }
    }
  }

  subscribeForDevices(){
    this.sensorService.subscribeDevices();
  }

  handleNotifications(notificationFlag){
    const message: string = notificationFlag;
    let audio: HTMLAudioElement = new Audio('https://drive.google.com/uc?export=download&id=1M95VOpto1cQ4FQHzNBaLf0WFQglrtWi7');
    switch (message){
        case 'connected': {
          audio.play().then(r => {});
          this.snackBar.open('There is device connected!', 'ok', {
            duration: 2000,
          } );
          this.getDevices();
          break;
        }
        case 'disconnected': {
          this.getDevices();
          break;
        }
        default: {
          audio.play().then(r => {});
          let messages = message.split(',');
          this.snackBar.open('There is new baby issue !', 'ok', {
            duration: 2000,
          } );
          this.sensorService.babiesIssues.next(messages[1]);
          break;
        }
      }
  }

  getDevices(){
    this.sensorService.getDevices().subscribe(resp => this.saveReceivedDevices(resp));
  }

  saveReceivedDevices(resp) {
    const devices = resp.body;
    this.sensorService.monitoringDevices = [];
    this.devices = [];
    this.currentReads = [];
    console.log(resp);

    for (const deviceNum in devices){
      const newDevice = new DeviceModel();
      newDevice.deviceId = devices[deviceNum].deviceId;
      newDevice.babyName = devices[deviceNum].babyName;
      for (let read of devices[deviceNum].tempReads){
        newDevice.tempReads.tempRead.push(read.value);
        newDevice.tempReads.readTime.push(read.time);
      }
      for (let read of devices[deviceNum].heartRateReads){
        newDevice.heartRateReads.heartRateRead.push(read.value);
        newDevice.heartRateReads.readTime.push(read.time);
      }
      for (let read of devices[deviceNum].spo2Reads){
        newDevice.spo2Reads.spo2Read.push(read.value);
        newDevice.spo2Reads.readTime.push(read.time);
      }
      this.sensorService.monitoringDevices.push(newDevice);
      this.devices.push(newDevice);
      this.positionReads.push('Undefined');
    }
    this.tempReads.length = this.devices.length;
    this.heartrateReads.length = this.devices.length;
    this.spo2Reads.length = this.devices.length;
    this.sensorService.devicesArrived.next(true);
  }

  addNewDevice(deviceId, babyName): void{
    this.sensorService.addDevice(deviceId.value, babyName.value).subscribe((response) => {
      if (response.status === 200) {
        deviceId.value = '';
        babyName.value = '';
        this.getDevices();
      } else {
      }
    });
  }

  showGraph(graphName: string, deviceId: number): void{
    const dialogConfig = {
      autoFocus : true,
      data : {
        num : deviceId
      }
    };
    let dialogRef;
    switch (graphName){
      case 'temp':
        dialogRef = this.dialog.open(TempChartComponent, dialogConfig);
        break;
      case 'heart':
        dialogRef = this.dialog.open(HeartRateChartComponent, dialogConfig);
        break;
      case 'respir':
        dialogRef = this.dialog.open(RespirChartComponent, dialogConfig);
        break;
    }
  }
}
