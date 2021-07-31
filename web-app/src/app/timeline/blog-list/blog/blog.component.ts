import {Component, Input, OnInit} from '@angular/core';
import {BlogModel} from '../../../models/blog.model';
import {DomSanitizer} from '@angular/platform-browser';
import {CreateBlogComponent} from '../../create-blog/create-blog.component';
import {MatDialog} from '@angular/material/dialog';
import {BlogDetailComponent} from './blog-detail/blog-detail.component';
import {BlogService} from '../../../services/Blog.service';
import {LikeModel} from '../../../models/like.model';
import {UserService} from '../../../services/user.service';
import { User } from 'src/app/models/user.model';

@Component({
  selector: 'app-blog',
  templateUrl: './blog.component.html',
  styleUrls: ['./blog.component.css']
})
export class BlogComponent implements OnInit {
  @Input() blog: BlogModel;
  @Input() index: number;
  dialogRef;
  likeIt: boolean = false ;
  like: LikeModel = null;
  defaultImae = '../../assets/images/default.jpg';
  image;
  userImage;
  constructor(private sanitizer: DomSanitizer, public dialog: MatDialog, private blogService: BlogService, private userService: UserService) { }

  ngOnInit(): void {
    let audio: HTMLAudioElement = new Audio('https://drive.google.com/uc?export=download&id=1M95VOpto1cQ4FQHzNBaLf0WFQglrtWi7');
    this.initialize();
    this.blogService.blogNotification.subscribe((notification) => {
      if (this.blogService.newBlogs !== notification) {
        notification = (notification as BlogModel);
        if (notification.id === this.blog.id) {
          this.blog = notification;
          audio.play();
          console.log(notification);
          this.initialize();
        }
      }
    });
  }


  initialize() {
    const object = 'data:' + this.blog.image.type + ';base64,' + this.blog.image.picByte;
    this.image = this.sanitizer.bypassSecurityTrustUrl(object);
    if (this.blog.user.profileImg !== undefined && this.blog.user.profileImg !== null ) {
      const imageBase = 'data:' + this.blog.user.profileImg.type + ';base64,' + this.blog.user.profileImg.picByte;
      this.userImage = this.sanitizer.bypassSecurityTrustUrl(imageBase);
    } else {
      this.userImage = '../../assets/images/default.jpg';
    }
    console.log("from beginig",  this.userService.theUser.username);
    for (const like of this.blog.likes) {
      if (like.user.username ===  this.userService.theUser.username) {
        this.likeIt = true;
        this.like = like;
        console.log("from beginig");
        break;
      }
    }
  }

  openDialog(){
    this.dialogRef = this.dialog.open(BlogDetailComponent, {
      height: '90%',
      width: '80%'
    });
    this.dialogRef.componentInstance.blog = this.blog;
    this.dialogRef.componentInstance.index = this.index;
    this.dialogRef.componentInstance.detailDialogRef = this.dialogRef;
    this.dialogRef.afterClosed().subscribe(result => {
      console.log(`Dialog result: ${result}`);
    });
  }
  onLike(deleteLike: boolean){
    if(deleteLike){

      if (this.like !== null) {
        this.blogService.deleteLike(this.like.id).subscribe((response) => {
          if (response.status === 200) {
            this.likeIt = false;
            const likeIndex = this.blog.likes.indexOf(this.like);
            // this.blogService.blogs[this.index].likes.splice(likeIndex, 1);
            // this.blog = this.blogService.blogs[this.index];
            this.like = null;
          }
        });
      }
    } else {
      this.blogService.addLike(this.blog.id).subscribe((response) => {
        if (response.status === 200) {
          this.likeIt = true;

          this.like = response.body as LikeModel;
          // this.blogService.blogs[this.index].likes.push(this.like);
          // this.blog = this.blogService.blogs[this.index];
        }
      });
    }
  }


}
