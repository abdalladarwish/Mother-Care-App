import {Injectable, NgZone} from '@angular/core';
import {Observable, Subject} from 'rxjs';
import {HttpClient, HttpResponse} from '@angular/common/http';
import {TokenService} from './Token.service';
import {DeviceModel} from '../models/device.model';
import {stringify} from '@angular/compiler/src/util';


@Injectable({
  providedIn : 'root'
})
export class DeviceService {

   public monitoringDevices: DeviceModel[] = [];

   graphsSubject: Subject<any>;

   babiesIssues: Subject <string>;

   devicesArrived : Subject<boolean>;

   sensorSent: Subject<any>

   devicesEventSources: EventSource[];

  constructor(private http: HttpClient, private tokenService: TokenService, private zone : NgZone) {
    this.graphsSubject = new Subject<any>();
    this.babiesIssues = new Subject<string>();
    this.devicesArrived = new Subject<boolean>();
    this.sensorSent = new Subject();
    this.devicesEventSources = [];
  }

  addDevice(deviceId: number, babyName: string): Observable<HttpResponse<object>>{
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    const body = new DeviceModel();
    body.deviceId = deviceId;
    body.babyName = babyName;
    return this.http.post('http://localhost:8080/device', body , {observe: 'response', headers});
  }

  getDevices(): Observable<HttpResponse<object>>{
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    }
    return this.http.get('http://localhost:8080/devices', {observe: 'response', headers});
  }

  subscribeDevices(){
    for (const eventSource in this.devicesEventSources){
      const headers = {
        Authorization: 'Bearer ' + this.tokenService.getToken(),
        'Content-type': 'application/json'
      };
      this.http.get('http://localhost:8080/device/' + this.monitoringDevices[eventSource].deviceId + '/unsubscription', {observe: 'response', headers});
      this.devicesEventSources[eventSource].close();
    }
    this.devicesEventSources = [];
    for (const num in this.monitoringDevices){
      const device = this.monitoringDevices[num];
      const eventSource = new EventSource('http://localhost:8080/device/' + device.deviceId + '/subscription');
      if (eventSource != null){
        eventSource.onmessage = event => {
          const dataJson = JSON.parse(event.data);
          this.monitoringDevices[num].tempReads.tempRead.push(dataJson.tempRead.value);
          this.monitoringDevices[num].tempReads.readTime.push(dataJson.tempRead.time);
          this.monitoringDevices[num].heartRateReads.heartRateRead.push(dataJson.heartRateRead.value);
          this.monitoringDevices[num].heartRateReads.readTime.push(dataJson.heartRateRead.time);
          this.monitoringDevices[num].spo2Reads.spo2Read.push(dataJson.spo2Read.value);
          this.monitoringDevices[num].spo2Reads.readTime.push(dataJson.spo2Read.time);
          this.monitoringDevices[num].positionRead = dataJson.positionRead;
          this.sensorSent.next(num);
         this.graphsSubject.next(num);
        };
      }
      this.devicesEventSources.push(eventSource);
    }
  }

  getBabiesIssues(): Observable<HttpResponse<object>>{
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    return this.http.get('http://localhost:8080/babies/issues', {observe: 'response', headers});
  }

  getGraphSubject(): Subject<any>{
    return this.graphsSubject;
  }

  getLastIssue(babyname : string): Observable<any> {
    const headers = {
    Authorization: 'Bearer ' + this.tokenService.getToken(),
    'Content-type': 'application/json'
  };
    return this.http.get('http://localhost:8080/last/issue/' + babyname, {observe: 'response', headers});
  }

}
