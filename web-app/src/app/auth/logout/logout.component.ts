import { Component, OnInit } from '@angular/core';
import {Router} from "@angular/router";
import {TokenService} from "../../services/Token.service";
import {MatDialogRef} from "@angular/material/dialog";

@Component({
  selector: 'app-logout',
  templateUrl: './logout.component.html',
  styleUrls: ['./logout.component.css']
})
export class LogoutComponent implements OnInit {

  constructor(public dialogRef : MatDialogRef<LogoutComponent>, private tokenService: TokenService,   private router: Router) { }

  ngOnInit(): void {
  }

  logOut(){
    this.tokenService.saveToken(null);
    this.router.navigate(['/login']);
    this.dialogRef.close();
  }
}
