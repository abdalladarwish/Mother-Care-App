import {PostModel} from '../models/post.model';
import {HttpClient, HttpErrorResponse, HttpParams} from '@angular/common/http';
import {Injectable} from '@angular/core';
import {toString} from '@ng-bootstrap/ng-bootstrap/util/util';
import {stringify} from 'querystring';
import {User} from '../models/user.model';
import {TokenService} from './Token.service';
import {async, Subject, throwError} from 'rxjs';
import {catchError} from 'rxjs/operators';
import {getClassName} from 'codelyzer/util/utils';
// import {type} from 'os';

@Injectable({providedIn: 'root'})
export class PostService{
  public postsSubject = new Subject<PostModel[]>();
  posts: PostModel[];

  constructor(private http: HttpClient, private tokenService: TokenService) {
  }
  getPosts() {
    return this.posts.slice();
  }
  addPost(post: PostModel) {
    this.posts.push(post);
  }
  getPostByIndex(index: number) {
    return this.posts[index];
  }

  savePost(image: FormData, post: PostModel ){
    console.log(this.tokenService.getToken());
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken(),
      'Content-type': 'application/json'
    };
    return this.http.post('http://localhost:8080/post/save',  JSON.parse(JSON.stringify(post)) , {observe: 'response', headers: headers }).pipe(catchError(this.handleError))
      .subscribe((response) => {
      if (response.status === 200) {
        // this.addPost(new Post(stringify(post.get('text')), null, null, null));
        console.log('Image uploaded successfully');
      } else {
        console.log('Image not uploaded successfully');
      }
    });
  }

  uploadPosts(){
    const headers = {
      Authorization: 'Bearer ' + this.tokenService.getToken()
    };
     this.http.get('http://localhost:8080/post/get', {headers}).subscribe(
      res => {
        const posts: PostModel[] = ( JSON.parse(JSON.stringify(res)) as PostModel[]);
        this.posts = posts;
        console.log(this.posts[4] );
        console.log(posts[0]);
        this.postsSubject.next(this.getPosts());
      }
    );

  }
  getJsonFromFormData(formData: FormData){
    const object = {};
    formData.forEach((value, key) => {
      // Reflect.has in favor of: object.hasOwnProperty(key)
      if (!Reflect.has(object, key)){
        object[key] = value;
        return;
      }
      if (!Array.isArray(object[key])){
        object[key] = [object[key]];
      }
      object[key].push(value);
    });
    const json = JSON.stringify(object);
    console.log(json);
    return json;
  }
  private handleError(errResp: HttpErrorResponse) {
    if (errResp.status == 200){
      return ;
    }else {
      let errorMessage = 'An unknown error message';
      if (!errResp.error || !errResp.error.error) {
        return throwError(errorMessage);
      }
      switch (errResp.error.message) {
        case 'EMAIL_EXISTS':
          errorMessage = 'This email is already exists';
          break;
        case 'INVALID_USERNAME_PASSWORD':
          errorMessage = 'This is invalid username or password';
        default:
          errorMessage = 'Something wrong happened';
      }
      return throwError(errorMessage);
    }
  }
}
