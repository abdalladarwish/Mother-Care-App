import { Component, OnInit } from '@angular/core';
import {NgForm} from '@angular/forms';
import {AuthenticationService} from "../../services/authentication.service";
import {TokenService} from "../../services/Token.service";
import {Router} from "@angular/router";
import {UserService} from '../../services/user.service';
import {BlogService} from '../../services/Blog.service';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {
  isLoading:boolean = false;
  error : string;
  passVis = 'password';

  constructor(private authService : AuthenticationService, private tokenService: TokenService,
              private router: Router, private userService: UserService, private blogService: BlogService) { }

  ngOnInit(): void {
  }

  onSubmitForm(form: NgForm){
    let username :string = form.value.username;
    let password : string = form.value.password;
    this.isLoading = true;
    this.authService.login(username, password)
      .subscribe(( response) => {
        if (response.status === 200 ){
          console.log(response.body);
          this.tokenService.saveToken( response.body['access_token']);
          this.userService.getUser().subscribe((response) => {
            console.log(response.body);
          });
          this.router.navigate(['/profile']);
          this.blogService.getUpdates();
        }
      }, resError => {
        this.error = resError;
      });
    this.isLoading = false;
  }

  toggleVisibiltiy(){
    if (this.passVis === 'text'){
      this.passVis = 'password';
    } else {
      this.passVis = 'text';
    }
  }
}
