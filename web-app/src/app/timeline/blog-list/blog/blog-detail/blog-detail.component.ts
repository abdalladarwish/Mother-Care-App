import {ChangeDetectorRef, Component, Input, OnInit} from '@angular/core';
import {BlogModel} from '../../../../models/blog.model';
import {BlogService} from '../../../../services/Blog.service';
import {ActivatedRoute} from '@angular/router';
import {MatDialog} from '@angular/material/dialog';
import {CreateBlogComponent} from '../../../create-blog/create-blog.component';
import {LikeModel} from '../../../../models/like.model';
import {UserService} from '../../../../services/user.service';
import {ImageModel} from '../../../../models/image.model';
import {CommentModel} from '../../../../models/comment.model';
import {DomSanitizer} from '@angular/platform-browser';
import {MatSnackBar} from '@angular/material/snack-bar';

@Component({
  selector: 'app-blog-detail',
  templateUrl: './blog-detail.component.html',
  styleUrls: ['./blog-detail.component.css']
})
export class BlogDetailComponent implements OnInit {
  blog: BlogModel;
  // tslint:disable-next-line:variable-name
  @Input() blog_: BlogModel = null;
  @Input() newTap = false;
  detailDialogRef;
  createDialogRef;
  index: number;
  selectedFile: File;
  likeIt = false;
  like: LikeModel = null;
  image;
  myBlog;
  defaultImae = '../../assets/images/default.jpg';

  constructor(public dialog: MatDialog, private userService: UserService,
              private blogService: BlogService, private sanitizer: DomSanitizer,
              private snackBar: MatSnackBar, private changeDetectorRef: ChangeDetectorRef) { }

  ngOnInit(): void {
    if (this.blog_ !== null){
      this.blog = this.blog_;
    }
    this.myBlog = this.blog.user.username === this.userService.theUser.username;
    this.initialize();
    this.blogService.blogNotification.subscribe((notification) => {
      if (this.blogService.newBlogs !== notification) {
        notification = (notification as BlogModel);
        if (notification.id === this.blog.id) {
          console.log(notification);

          this.blog = notification;
          this.blog_ = notification;
          this.initialize();
          this.changeDetectorRef.detectChanges();
        }
      }
    });
  }
  initialize() {
    if (this.blog.user.profileImg === null) {
      this.image = this.defaultImae;
    } else {
      const object = 'data:' + this.blog.user.profileImg.type + ';base64,' + this.blog.user.profileImg.picByte;
      this.image = this.sanitizer.bypassSecurityTrustUrl(object);
    }
    for (const like of this.blog.likes) {
      if (like.user.username === this.userService.theUser.username) {
        this.likeIt = true;
        this.like = like;
        break;
      }
    }
  }
  closeDialog() {
    this.detailDialogRef.close();
  }

  openDialogCreate(){
    this.detailDialogRef.close();
    this.createDialogRef = this.dialog.open(CreateBlogComponent, {
      height: '90%',
      width: '80%'
    });

    this.createDialogRef.componentInstance.blogEdit = this.blog;
    this.createDialogRef.componentInstance.editBlog = true;
    this.createDialogRef.componentInstance.dialogRef = this.createDialogRef;
    this.createDialogRef.afterClosed().subscribe(result => {
      console.log(`Dialog result: ${result}`);
    });
  }

  onFileChanged(event){
    this.selectedFile = event.target.files[0];
  }

  saveComment(text: HTMLInputElement){

    if (this.selectedFile != null) {
      const reader = new FileReader();
      reader.onload = (e) => {
        // tslint:disable-next-line:one-variable-per-declaration
        const array = new Uint8Array(e.target.result as ArrayBuffer),
            image = this.selectedFile != null ? new ImageModel(0, this.selectedFile.name,
                this.selectedFile.type, btoa(String.fromCharCode.apply(null, array))) : null;
        const comment = new CommentModel(0, text.value, image, null, null, null);

        this.blogService.saveComment(this.blog.id, comment).subscribe(response => {
          if (response.status === 200) {
            this.blog = response.body as BlogModel;
            console.log(this.blog);
          } else {
            console.log('response', response.body);
          }
        });
      };
      reader.readAsArrayBuffer(this.selectedFile);
    }else {
      const comment = new CommentModel(0, text.value, null, null, null, null);

      this.blogService.saveComment(this.blog.id, comment).subscribe(response => {
        if (response.status === 200) {
          this.blog = response.body as BlogModel;
          console.log(this.blog);
        } else {
          console.log('response', response.body);
        }
      });
    }
  }

  onLike(deleteLike: boolean){
    if (deleteLike){
      this.blogService.deleteLike(this.like.id).subscribe((response) => {
        if (response.status === 200) {
          this.likeIt = false;
          const likeIndex = this.blog.likes.indexOf(this.like);
          // this.blogService.blogs[this.index].likes.splice(likeIndex, 1);
          // this.blog = this.blogService.blogs[this.index];
        }
      });
    } else {
      this.blogService.addLike(this.blog.id).subscribe((response) => {
        if (response.status === 200) {
          this.likeIt = true;
          this.like =  response.body as LikeModel;
          // this.blogService.blogs[this.index].likes.push( response.body as LikeModel);
          // this.blog = this.blogService.blogs[this.index];
        }
      });
    }
  }

  activateSnack(status){
    if (status === 200) {
      this.detailDialogRef.close()
      this.snackBar.open('blog deleted suceesfully!!', 'ok', {
        duration: 2000,
        panelClass: ['green-snack']
      } );
    } else {
      this.snackBar.open('Failure! please try again', 'ok', {
        duration: 2000,
        panelClass: ['red-snack']
      } );
    }
  }

  deleteBlog() {
    this.blogService.deleteBlog(this.blog.id).subscribe((response) => {
      this.activateSnack(response.status);
    });
  }

}
