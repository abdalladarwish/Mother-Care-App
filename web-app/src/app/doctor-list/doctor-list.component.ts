import { Component, OnInit } from '@angular/core';
import {DoctorService} from '../services/doctor.service';
import {Doctor, speacialization, degree, cities} from '../models/doctor.model';


@Component({
  selector: 'app-doctor-list',
  templateUrl: './doctor-list.component.html',
  styleUrls: ['./doctor-list.component.css'],
  providers: [DoctorService]
})
export class DoctorListComponent implements OnInit {
  doctorsList :Doctor[];
  speacialtiy:string = "All";
  location:string = "All";
  degree:string = "All";

  constructor(private doctorService : DoctorService) { }

  ngOnInit(): void {
    this.doctorsList = this.doctorService.getDoctors();
  }

  changeSpectiality(event :Event){
    this.speacialtiy = (<HTMLButtonElement>event.currentTarget).name;
  }

  changeLocation(event :Event){
    this.location = (<HTMLButtonElement>event.currentTarget).name;
  }

  changeDegree(event :Event){
    this.degree = (<HTMLButtonElement>event.currentTarget).name;
  }

  searchDoctors(){
    let temp = this.doctorService.getDoctors()
    if (this.speacialtiy === "All")
    {
      this.doctorsList = temp
    }
    else{
      this.doctorsList = temp.filter(doctor => doctor.speciality === this.speacialtiy);
    }
  }

}
