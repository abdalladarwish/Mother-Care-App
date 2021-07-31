import {Component, Input, OnInit} from '@angular/core';
import {PageEvent} from '@angular/material/paginator';
import {BlogModel} from '../../../models/blog.model';
import {BlogService} from '../../../services/Blog.service';

@Component({
  selector: 'app-all-blogs',
  templateUrl: './all-blogs.component.html',
  styleUrls: ['./all-blogs.component.css']
})
export class AllBlogsComponent implements OnInit {
  breakpoint;
  pageEvent: PageEvent;
  totalLength: number = 0;
  pageIndex: number = 0;
  currentMaxId: number;
  startIndex: number = 0;
  endIndex: number;
  blogs: BlogModel[] ;
  user: string = 'mother-care';
  category: string ='all';
  categoryList: string[] = ['COVID-19', 'Pregnancy','Labor', 'Delivery', 'Breast Feeding', 'Baby', 'Exercise'];
  constructor(private blogService: BlogService) { }


  ngOnInit() {
    this.initialize(0);
    this.blogService.blogNotification.subscribe((notification) => {

    });
    this.breakpoint = (window.innerWidth - 150) > 400 ? (( (window.innerWidth - 150) / 370) - ((window.innerWidth - 150) % 370) / 370) : 1;
  }

  initialize( index: number) {
    this.blogService.BlogsCount(this.user, this.category).subscribe((response) => {
      if (response.status === 200) {
        console.log(response.body);
        this.totalLength = (response.body as number);
      }
    })
    this.blogService.blogSubject.subscribe((blogs) => {
      if (this.blogs === undefined || index == 0) {
        this.startIndex = 0;
        index = 1;
      } else{
        this.startIndex = this.blogs.length;
      }
      this.endIndex = this.blogService.getBlogs().length;
      this.currentMaxId = this.blogService.getBlogs()[(this.endIndex - 1)].id;
      this.blogs = this.blogService.getBlogs().slice(this.startIndex, this.endIndex);
      console.log("the last id is", this.currentMaxId);
    });
    this.blogService.uploadBlogs(index, this.user, this.category);

  }
  onResize(event) {
    this.breakpoint = (event.target.innerWidth - 150) > 400 ? (((event.target.innerWidth - 150) / 370) - ((event.target.innerWidth - 150) % 370) / 370) : 1;
  }

  getServerData(event: PageEvent){

      if (event.pageIndex > this.pageIndex){
        if ( (event.pageIndex + 1) * 12 <= this.blogService.getBlogs().length  ){
          this.startIndex = 12* this.pageIndex;
          this.endIndex = 12 + this.startIndex;
          this.blogs = this.blogService.getBlogs().slice(this.startIndex, this.endIndex);
        } else {
          this.blogService.uploadBlogs(this.currentMaxId, this.user, this.category);
        }

      } else {
        this.startIndex = 12* event.pageIndex;
        this.endIndex = 12 + this.startIndex;
        this.blogs = this.blogService.getBlogs().slice(this.startIndex, this.endIndex);
      }
      this.pageIndex = event.pageIndex;
    return event;
  }

  authorChanged(author: string){
    console.log(author);
    this.user = author;
    this.initialize(0);
    this.pageIndex = 0;
  }
  categoryChanged(category: string){
    console.log(category);
    this.category = category;
    this.initialize(0);
    this.pageIndex = 0;
  }
}
