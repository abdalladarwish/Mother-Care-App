import { Component, OnInit } from '@angular/core';
import {BlogService} from '../../../services/Blog.service';
import {BlogModel} from '../../../models/blog.model';
import {PageEvent} from '@angular/material/paginator';
import {UserService} from '../../../services/user.service';

@Component({
  selector: 'app-my-blogs',
  templateUrl: './my-blogs.component.html',
  styleUrls: ['./my-blogs.component.css']
})
export class MyBlogsComponent implements OnInit {
  allBlogs;
  blogs: BlogModel[];
  breakpoint;
  pageEvent: PageEvent;
  totalLength: number = 0;
  pageIndex: number = 0;
  startIndex: number = 0;
  endIndex: number;
  constructor(private blogService: BlogService, private userService: UserService) { }

  ngOnInit(): void {
    this.blogService.blogNotification.subscribe(notification => {
    });
    this.blogService.myBlogs().subscribe((response) => {
      if (response.status === 200) {
        this.allBlogs = (response.body as BlogModel[]);
        this.totalLength = this.allBlogs.length;
        if (this.totalLength < 12) {
          this.endIndex = this.allBlogs.length;
        } else {
          this.endIndex = 12;
        }
        this.blogs = this.allBlogs.slice(this.startIndex, this.endIndex);
      }
    });
    this.breakpoint = (window.innerWidth - 150) > 400 ? (( (window.innerWidth - 150) / 370) - ((window.innerWidth - 150) % 370) / 370) : 1;
  }

  onResize(event) {
    this.breakpoint = (event.target.innerWidth - 150) > 400 ? (((event.target.innerWidth - 150) / 370) - ((event.target.innerWidth - 150) % 370) / 370) : 1;
  }

  getServerData(event: PageEvent){
    // event.pageIndex

      if (event.pageIndex > this.pageIndex){

          this.startIndex = 12* this.pageIndex;
          this.endIndex = 12 + this.startIndex;
          this.blogs = this.allBlogs.slice(this.startIndex, this.endIndex);

      } else {
        this.startIndex = 12* event.pageIndex;
        this.endIndex = 12 + this.startIndex;
        this.blogs = this.blogService.getBlogs().slice(this.startIndex, this.endIndex);
      }
      this.pageIndex = event.pageIndex;
      return event;
    }


}
