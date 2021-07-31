import { Component, OnInit } from '@angular/core';
import {AuthenticationService} from '../../services/authentication.service';
import {ActivatedRoute, Router} from '@angular/router';
import {timer} from 'rxjs';

@Component({
  selector: 'app-confirm-account',
  templateUrl: './confirm-account.component.html',
  styleUrls: ['./confirm-account.component.css']
})
export class ConfirmAccountComponent implements OnInit {
  confirmed = "we are confirming your account";
  result;
  color = '';
  time = 0;
  constructor(private authService:AuthenticationService, private activatedRoute: ActivatedRoute, private router : Router) { }

  ngOnInit(): void {
    this.activatedRoute.params.subscribe(params => {
      let token = params['token'];
      this.authService.confirmAccount(token).subscribe((response) => {
        if (response.status === 200) {
          this.result = 'your account is confirmed successfully';
          this.color =  'green';
          const timer3s = timer(3000);
          timer3s.subscribe((val) => {
            this.router.navigate(['/login']);
          });
        }
        else {
          this.result = 'Sorry! try again later';
          this.color = 'red';
        }
      });
    });

  }
}
