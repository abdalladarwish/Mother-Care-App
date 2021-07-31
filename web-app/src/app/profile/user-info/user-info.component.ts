import {Component, OnInit} from "@angular/core";
import {UserService} from "../../services/user.service";
import {User} from "../../models/user.model";


@Component({
  selector: 'user-info',
  templateUrl: './user-info.component.html',
  styleUrls: ['./user-info.component.css']
})
export class UserInfoComponent implements OnInit{
  theUser : User = null;
  constructor(public userService : UserService) {
  }

  ngOnInit(): void {
    this.theUser = this.userService.theUser;
  }
}
