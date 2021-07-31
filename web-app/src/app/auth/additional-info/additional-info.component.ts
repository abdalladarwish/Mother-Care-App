import { Component, OnInit } from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {MatStepperIntl} from "@angular/material/stepper";
import {MatDialogRef} from "@angular/material/dialog";
import {UserInfoModel} from "../../models/user-info.model";
import {UserService} from "../../services/user.service";
import {Router} from "@angular/router";

@Component({
  selector: 'app-additional-info',
  templateUrl: './additional-info.component.html',
  styleUrls: ['./additional-info.component.css']
})
export class AdditionalInfoComponent implements OnInit {
  userInfo : UserInfoModel;
  error : string;
  pregnant : string;
  haveChildren : string;

  constructor(public dialogRef: MatDialogRef<AdditionalInfoComponent>, private userService : UserService, private router: Router) {}

  ngOnInit(): void {
    this.userInfo = new UserInfoModel();
    this.userInfo.bloodType = "";
    this.userInfo.pregnant = false;
    this.userInfo.haveChildren = false;
    this.userInfo.weight = 0;
    this.userInfo.height = 0;
    this.userInfo.anemiaRate = 0;
    this.userInfo.childrenNum = 0;
    this.userInfo.pregnancyDate = null;
    this.userInfo.periodLength = 0;
    this.userInfo.lastPeriodDate = null;
  }

  addUserInfo(){
    if (this.pregnant == "yes"){
      this.userInfo.pregnant = true;
    }
    if (this.haveChildren == "yes"){
      this.userInfo.haveChildren = true;
    }
    this.userInfo.periodLength = +this.userInfo.periodLength;
    this.userService.addUserInfo(this.userInfo).subscribe(resData => {
      this.dialogRef.close();
      this.router.navigate(['/profile']);
    }, resError => {
      this.error = resError;
    });
  }

  skipUserInfo(){
    this.userService.skipUserInfo().subscribe(resp => {
      this.dialogRef.close();
      this.router.navigate(['/profile']);
    }, respError => {
      this.error = respError;
    })
  }
}
