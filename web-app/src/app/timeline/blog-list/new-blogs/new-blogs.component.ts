import {ChangeDetectorRef, Component, OnInit} from '@angular/core';
import {BlogModel} from '../../../models/blog.model';
import {PageEvent} from '@angular/material/paginator';
import {BlogService} from '../../../services/Blog.service';
import {UserService} from '../../../services/user.service';

@Component({
  selector: 'app-new-blogs',
  templateUrl: './new-blogs.component.html',
  styleUrls: ['./new-blogs.component.css']
})
export class NewBlogsComponent implements OnInit {

  blogs: BlogModel[];
  breakpoint;

  constructor(private blogService: BlogService, private userService: UserService, private changeDetectorRef: ChangeDetectorRef) { }

  ngOnInit(): void {
    this.blogs = this.blogService.newBlogs;
    console.log("as starter", this.blogs);
    this.breakpoint = (window.innerWidth - 150) > 400 ? (( (window.innerWidth - 150) / 370) - ((window.innerWidth - 150) % 370) / 370) : 1;
  }

  onResize(event) {
    this.breakpoint = (event.target.innerWidth - 150) > 400 ? (((event.target.innerWidth - 150) / 370) - ((event.target.innerWidth - 150) % 370) / 370) : 1;
  }

}
