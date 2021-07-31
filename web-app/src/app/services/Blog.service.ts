import {HttpClient, HttpErrorResponse, HttpHeaders, HttpParams} from '@angular/common/http';
import {Injectable} from '@angular/core';
import {TokenService} from './Token.service';
import {async, Subject, throwError} from 'rxjs';
import {CommentModel} from '../models/comment.model';
import {isIterable} from 'rxjs/internal-compatibility';
import {UserService} from './user.service';
import {BlogModel} from '../models/blog.model';

@Injectable({providedIn: 'root'})
export class BlogService{
  public blogSubject = new Subject<BlogModel[]>();
  public blogNotification = new Subject<any>();
  blogs: BlogModel[] ;
  newBlogs: BlogModel[] = [];
  headers ;

  constructor(private http: HttpClient, private tokenService: TokenService, private userService: UserService) {
    this.tokenService.tokenSubject.subscribe(token => {
      this.headers = {
        Authorization: 'Bearer ' + this.tokenService.getToken()
      };
    });

  }
  getBlogs() {
    return this.blogs.slice();
  }
  addBlog(blog: BlogModel) {
    this.blogs.push(blog);
  }
  getBlogByIndex(index: number) {
    return this.blogs[index];
  }

  saveBlog(blog: BlogModel ){
    console.log(this.tokenService.getToken());

    // tslint:disable-next-line:max-line-length
    return this.http.post(this.tokenService.getIpAddress() + '/blog/save' ,blog , {observe: 'response', headers: this.headers });
  }

  BlogsCount(user: string, category: string) {

    return this.http.get(this.tokenService.getIpAddress() + '/blog/count/' + user + '/' + category , {observe: 'response', headers: this.headers});
  }
  uploadBlogs(lastId: number, userName: string, category: string){
    console.log(this.headers);
    this.http.get(this.tokenService.getIpAddress() + '/blog/get/' + userName + '/' + category + '/' + lastId, {observe: 'response', headers: this.headers}).subscribe(
      (response) => {
        const blogs: BlogModel[] = (response.body as BlogModel[]);
        console.log('service', response.body);
        if ( isIterable(blogs)){
          if (lastId !== 0)
          {
            for (const blog of blogs) {
              this.addBlog(blog);
            }
          }else
          {
            this.blogs = blogs;
          }
          this.blogSubject.next(this.getBlogs());
        }

      }
    );

  }
  saveComment(blohgId: number, comment: CommentModel){

    console.log(this.tokenService.getIpAddress() + '/comment' + blohgId);
    return this.http.post(this.tokenService.getIpAddress() + '/comment/' + blohgId, comment, { observe: 'response', headers: this.headers});

  }

  deleteBlog(id: number){
    return this.http.post(this.tokenService.getIpAddress() + '/blog/delete/' + id, null, {observe: 'response', headers: this.headers});
  }
  saveCommentToComment(commentId: number, comment: CommentModel){

    return this.http.post(this.tokenService.getIpAddress() + '/commentToComment/' + commentId, comment, { observe: 'response', headers: this.headers});

  }
  addLike(blogId: number){

    return this.http.post(this.tokenService.getIpAddress() + '/like/' + blogId, null, {observe: 'response', headers: this.headers});
  }
  deleteLike(likeId: number){

    return this.http.post(this.tokenService.getIpAddress() + '/like/delete/' + likeId, null, {observe: 'response', headers: this.headers});
  }

  bommarkBlog(blogId: number) {

    return this.http.post(this.tokenService.getIpAddress() + '/blog/bommark/' + blogId, null, {observe: 'response', headers: this.headers});
  }

  bommarks() {

    return this.http.get(this.tokenService.getIpAddress() + '/blog/bommark', {observe: 'response', headers: this.headers});
  }

  likedBlogs(){

    return this.http.get(this.tokenService.getIpAddress() + '/blog/liked', {observe: 'response', headers: this.headers});
  }

  myBlogs(){

    return this.http.get(this.tokenService.getIpAddress() + '/blog/my_blogs', {observe: 'response', headers: this.headers});
  }

  getUpdates(){

    const blogUpdateEvent = new EventSource(this.tokenService.getIpAddress() + '/blog/updates');
    // tslint:disable-next-line:typedef only-arrow-functions
    blogUpdateEvent.onmessage = event => {
      console.log('Message Received');
      // this.blogNotification.next(event.data);

      const notification = JSON.parse(event.data);
      console.log(this.userService.theUser.username, notification.operation, notification.entityType, notification.message);
      const blog = notification.message  as BlogModel;
      if (notification.entityType === 'Blog' && notification.operation === 'insert') {
        blog.likes = [];
        this.newBlogs.push(blog);
        this.blogNotification.next(this.newBlogs);
      } else if (notification.entityType === 'Blog' && notification.operation === 'delete') {
      } else {
        const blogCount = this.blogs.length;
        for(let i = 0; i < blogCount; i++) {
          if (this.blogs[i].id === blog.id) {
            this.blogs[i] = blog;
            this.blogNotification.next(blog);
            break;
          }
        }
      }

    };
    blogUpdateEvent.onerror = error =>
    {
      console.log('error Received');
      console.log(error.type);
      blogUpdateEvent.close();
      this.getUpdates();
    };
  }

  updateBlog(theBlog: BlogModel) {

    return this.http.post(this.tokenService.getIpAddress() + '/blog/update' , theBlog, {observe: 'response', headers: this.headers});
  }

  private handleError(errResp: HttpErrorResponse) {
    if (errResp.status === 200){
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
