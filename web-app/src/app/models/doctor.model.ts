export enum speacialization{
  Obstetrician= "Obstetrician",
  Pediatrician= " Pediatrician",
  Nutrition= "Nutrition"
}
export enum degree{
  professor

 }

export enum gender{
  M,
   F
 }
 export enum cities{
  cairo ="Cairo",
   giza = "Giza"
 }

export class Doctor{
  constructor(public id:number, public firstName:string, public lastName:string, public age:number, public speciality:speacialization,
              public  degree:degree, public fees:number, public gender:gender, public location:cities, public img:string, public phone:string) {
  }
}
