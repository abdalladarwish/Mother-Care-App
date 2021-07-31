import { Component, Input, OnInit } from '@angular/core';
import {absRound} from 'ngx-bootstrap/chronos/utils/abs-round';
import {PageEvent} from '@angular/material/paginator';
import {BlogService} from '../../services/Blog.service';
import {BlogModel} from '../../models/blog.model';
import { UserService } from 'src/app/services/user.service';

@Component({
  selector: 'app-blog-list',
  templateUrl: './blog-list.component.html',
  styleUrls: ['./blog-list.component.css']
})
export class BlogListComponent implements OnInit {

  @Input() savedBlogs: boolean = false;
  @Input() myBlogs: boolean = false;
  @Input() newBlogs: boolean = false;
  constructor() { }

  ngOnInit() {

  }
}
