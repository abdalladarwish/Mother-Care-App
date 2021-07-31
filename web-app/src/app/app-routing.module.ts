import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {HomeComponent} from './home/home.component';
import {SignupComponent} from './auth/signup/signup.component';
import {LoginComponent} from './auth/login/login.component';
import {DoctorListComponent} from './doctor-list/doctor-list.component';
import {ProfileComponent} from "./profile/profile.component";
import {TimelineComponent} from './timeline/timeline.component';
import {AdditionalInfoComponent} from "./auth/additional-info/additional-info.component";
import {BlogNewTapComponent} from './timeline/blog-list/blog/blog-new-tap/blog-new-tap.component';
import {ConfirmAccountComponent} from './auth/confirm-account/confirm-account.component';

const appRoutes: Routes = [
  {path: '', component: HomeComponent},
  {path : 'signup', component: SignupComponent},
  {path: 'login', component: LoginComponent},
  {path: 'bookdoctor', component: DoctorListComponent},
  {path: 'profile', component: ProfileComponent},
  {path: 'timeline', component: TimelineComponent},
  {path: 'userInfo', component: AdditionalInfoComponent},
  {path: 'blog/:index', component: BlogNewTapComponent},
  {path: 'confirm-account/:token', component: ConfirmAccountComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(appRoutes, { relativeLinkResolution: 'legacy' })],
  exports: [RouterModule]
})
export class AppRoutingModule{

}
