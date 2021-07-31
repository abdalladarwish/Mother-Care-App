import {Injectable} from "@angular/core";
import {User} from "../models/user.model";
import {HttpClient, HttpErrorResponse, HttpParams} from "@angular/common/http";
import {DeviceModel} from "../models/device.model";
import {TokenService} from "./Token.service";
import {catchError} from "rxjs/operators";
import {UserInfoModel} from "../models/user-info.model";
import {Subject, throwError} from 'rxjs';
import {BlogService} from './Blog.service';

@Injectable({providedIn:"root"})
export class UserService{

  theUser : any;

  userReceived: Subject<boolean>;

  constructor(private httpClient : HttpClient, private tokenService : TokenService) {
    this.userReceived = new Subject();
  }

  getUser(){
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    return this.httpClient.get('http://localhost:8080/user', {observe: 'response', headers}).pipe(
      catchError(this.handleError)
    );

  }

  saveProfileImg(selectedFile : File){
    const uploadImageData = new FormData();
    uploadImageData.append('imageFile', selectedFile,selectedFile.name);
    return this.httpClient.post('http://localhost:8080/user/setProfilePic', uploadImageData, { observe: 'response' })
  }

  addUserInfo(userInfo: UserInfoModel){
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    console.log("request sent")
    return this.httpClient.post('http://localhost:8080/user/info', userInfo, {observe: 'response', headers}).pipe(
      catchError(this.handleError)
    );
  }


  skipUserInfo(){
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    return this.httpClient.post('http://localhost:8080/skipping/user/info', {observe: 'response', headers}).pipe(
      catchError(this.handleError)
    );
  }


  private handleError(errResp: HttpErrorResponse) {
    let errorMessage;
    switch (errResp.error.error){
      case ("invalid_grant"):
        errorMessage = "Invalid username or password";
        break;
      case ("user_exist"):
        errorMessage =errResp.error.error_description;
        break;
      case ("server_problem"):
        errorMessage = errResp.error.error_description;
        break;
      default:
        errorMessage =  'Unknown error';
        break;
    }
    return throwError(errorMessage);
  }
}
