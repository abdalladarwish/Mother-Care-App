import {cities, degree, Doctor, gender, speacialization} from '../models/doctor.model';

export class DoctorService{
  private doctors: Doctor[] = [new Doctor(1,"Abdullah","Elsayed",30, speacialization.Obstetrician,degree.professor,200,gender.M, cities.cairo,"../../assets/images/abdulla.jpg","+201147783885" )
  ,new Doctor(2,"Mohamed","Kamal",25, speacialization.Pediatrician,degree.professor,400,gender.M, cities.cairo,"../../assets/images/kamal.png", "+201100661997" ),
    new Doctor(3,"Abdullah","Drwesh",26, speacialization.Obstetrician,degree.professor,250,gender.M , cities.giza,"../../assets/images/drwesh.jpg", "+201120090244"),
    new Doctor(4,"Heba","Ali",23, speacialization.Nutrition,degree.professor,300,gender.F, cities.giza,"../../assets/images/heba.jpg", "+201100646124")]


  getDoctors():Doctor[]{
    return this.doctors.slice();
  }

  // getDoctorById(id: number):Doctor
  // {
  //   return this.doctors.filter(doctor => doctor.id === id)[0]
  // }
  //
  // getDoctorByName(name: string):Doctor
  // {
  //   return this.doctors.filter(doctor => doctor.firstName === name)[0]
  // }
  //
  // getDoctorsBySpectiality(specialization :speacialization):Doctor[]{
  //   return this.doctors.filter(doctor => doctor.speciality === specialization)
  // }

  getDoctorsByCity(city :cities): Doctor[]
  {
    return this.doctors.filter(doctor => doctor.location === city)
  }
}
