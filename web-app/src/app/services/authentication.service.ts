import {Injectable} from '@angular/core';
import {HttpClient, HttpErrorResponse, HttpParams} from '@angular/common/http';
import {User} from '../models/user.model';
import {Observable, Subject} from 'rxjs';
import {catchError} from 'rxjs/operators';
import {throwError} from 'rxjs';
import {TokenService} from './Token.service';


@Injectable({providedIn: 'root'})
export class AuthenticationService{
  public user = new Subject<User>();

  constructor(private http: HttpClient, private tokenService : TokenService) {}

  /* [Description] : METHOD USED TO SEND POST HTTP REQUEST TO THE API TO SIGN UP NEW USER
   *                 AND RETURN OBSERVABLE WHICH YOU SHOULD SUBSCRIBE TO GET TH RESPONSE.
   * [Parameters] : User OBJECT
   * [Returns] : Observable OBJECT
   */
  signup(newUser: { firstName: string; lastName: string; password: string; phone: string; email: string; username: string }): Observable<any>{
    return this.http.post('http://localhost:8080/new/user', newUser).pipe(catchError(this.handleError));
  }

  confirmAccount(token: string) {
    return this.http.get(this.tokenService.getIpAddress() + '/confirm-account?token=' + token, {observe: 'response'});
  }

  login(username: string, password: string): Observable<any>{
    const headers = {
      Authorization: 'Basic ' + btoa('mothercare-webapp:6969'),
      'Content-type': 'application/x-www-form-urlencoded'
    };
    const body = new HttpParams()
      .set('username', username)
      .set('password', password)
      .set('grant_type', 'password');
    return this.http.post('http://localhost:8080/oauth/token', body, {observe: 'response', headers}).pipe(catchError(this.handleError));
  }

  private handleError(errResp: HttpErrorResponse): any{
    let errorMessage;
    switch (errResp.error.error){
      case ('invalid_grant'):
        errorMessage = 'Invalid username or password';
        break;
      case ('user_exist'):
        errorMessage = errResp.error.error_description;
        break;
      case ('server_problem'):
        errorMessage = errResp.error.error_description;
        break;
      default:
        errorMessage =  'Unknown error';
        break;
    }
    return throwError(errorMessage);
  }


}
