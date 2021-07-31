import { Component, OnInit } from '@angular/core';
import {BlogService} from '../../../../services/Blog.service';
import {ActivatedRoute} from '@angular/router';
import {BlogModel} from '../../../../models/blog.model';

@Component({
  selector: 'app-blog-new-tap',
  templateUrl: './blog-new-tap.component.html',
  styleUrls: ['./blog-new-tap.component.css']
})
export class BlogNewTapComponent implements OnInit {
  blog: BlogModel;
  constructor(private blogService: BlogService, private activatedRoutes: ActivatedRoute) { }

  ngOnInit(): void {
    this.activatedRoutes.params.subscribe(params => {
      const index = params['index'];
      this.blog = this.blogService.getBlogByIndex(index);

    });
  }

}
