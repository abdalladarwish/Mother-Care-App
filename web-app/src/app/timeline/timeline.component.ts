import { Component, OnInit } from '@angular/core';
import {BlogService} from '../services/Blog.service';
import {BlogModel} from '../models/blog.model';
import {TokenService} from "../services/Token.service";
import {Router} from "@angular/router";

@Component({
  selector: 'app-timeline',
  templateUrl: './timeline.component.html',
  styleUrls: ['./timeline.component.css']
})
export class TimelineComponent implements OnInit {
  constructor(private tokenSErvice :  TokenService, private router : Router) { }

  ngOnInit(): void {
    if (this.tokenSErvice.getToken() == null){
      this.router.navigate(['/login']);
      return;
    }
  }

}
