import { Component, OnInit } from '@angular/core';
import {BlogModel} from '../../../models/blog.model';
import {PageEvent} from '@angular/material/paginator';
import {BlogService} from '../../../services/Blog.service';

@Component({
  selector: 'app-saved-blogs',
  templateUrl: './saved-blogs.component.html',
  styleUrls: ['./saved-blogs.component.css']
})
export class SavedBlogsComponent implements OnInit {
  allBlogs;
  blogs: BlogModel[];
  breakpoint;
  pageEvent: PageEvent;
  totalLength: number = 0;
  pageIndex: number = 0;
  startIndex: number = 0;
  endIndex: number;
  constructor(private blogService: BlogService) { }

  ngOnInit(): void {
    this.blogService.blogNotification.subscribe(notification => {

    });
    this.blogService.likedBlogs().subscribe((response) => {
      if (response.status === 200) {
        this.allBlogs = (response.body as BlogModel[]);
        console.log(response.body);
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
