import { Component, OnInit } from '@angular/core';
import {Subscription} from 'rxjs';
import {AuthenticationService} from '../services/authentication.service';
import {TokenService} from "../services/Token.service";
import {Router} from "@angular/router";
import {MatDialog} from "@angular/material/dialog";
import {LogoutComponent} from "../auth/logout/logout.component";

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css']
})
export class HeaderComponent implements OnInit {
  isCollapsed = true;
  companyTitle = 'MOTHER CARE';
  isAuthenticated = false;
  logoUrl = '../../assets/images/logo.svg';
  userSubscription: Subscription;

  constructor(private dialog : MatDialog, private authService: AuthenticationService, public tokenService: TokenService, private router : Router) { }

  ngOnInit(): void {
    this.userSubscription = this.authService.user.subscribe(theUser => {
      this.isAuthenticated = (theUser != null ? true : false);
    });
  }

  logout(){
    const config = {
      autoFocus : true,
    }
    this.dialog.open(LogoutComponent, config);
  }

}
