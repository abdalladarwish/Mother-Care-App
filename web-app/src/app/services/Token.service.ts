import {Injectable} from '@angular/core';
import {Subject} from 'rxjs';

@Injectable({providedIn: 'root'})
export class TokenService{
  private token: string = null;
  tokenSubject = new Subject<string>();
  ip: string = 'http://localhost:8080'

  saveToken(token: string){
    this.token = token;
    this.tokenSubject.next(token);
  }
  getToken(){
    return this.token;
  }

  getIpAddress(){
    return this.ip;
  }
}
