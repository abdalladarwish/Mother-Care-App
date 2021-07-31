import {Component, Input, OnInit} from '@angular/core';
import {ImageModel} from '../../../../../models/image.model';
import {CommentModel} from '../../../../../models/comment.model';
import {BlogService} from '../../../../../services/Blog.service';

@Component({
  selector: 'app-comment',
  templateUrl: './comment.component.html',
  styleUrls: ['./comment.component.css']
})
export class CommentComponent implements OnInit {

  @Input() comment: CommentModel;
  @Input() blogIndex: number;
  defaultImae = '../../assets/images/default.jpg';
  selectedFile: File;
  showReplies = false;


  constructor(private blogService: BlogService) { }

  ngOnInit(): void {
    // this.comment = this.postService.posts[this.postId].comments[this.commentId];
    // console.log(this.comment.user);
    // if ( !(this.comment.user  instanceof User)) {
    //   this.comment.user = this.blogService.getBlogByIndex(this.blogIndex).user;
    // }
  }
  onFileChanged(event){
    this.selectedFile = event.target.files[0];
  }
  hideReplies(){
    this.showReplies = ! this.showReplies;
  }
  saveCommentToComment(text: HTMLInputElement, commentId: number){
    if (this.selectedFile != null) {
      const reader = new FileReader();
      reader.onload = (e) => {
        const array = new Uint8Array(e.target.result as ArrayBuffer),
          image = this.selectedFile != null ? new ImageModel(0, this.selectedFile.name,
            this.selectedFile.type, btoa(String.fromCharCode.apply(null, array))) : null;
        const comment = new CommentModel(0, text.value, image, null, null, null);

        this.blogService.saveCommentToComment(commentId, comment).subscribe(response => {
          if (response.status === 200) {
            this.comment = response.body as CommentModel;
            console.log(comment.comments);
          } else {
            console.log(response.body);
          }
        });
      };
      reader.readAsArrayBuffer(this.selectedFile);
    }else {
      const comment = new CommentModel(0, text.value, null, null, null, null);

      this.blogService.saveCommentToComment(commentId, comment).subscribe(response => {
        if (response.status === 200) {
          this.comment = response.body as CommentModel ;
          console.log(this.comment.comments);
        } else {
          console.log(response.body);
        }
      });
    }
  }
}
