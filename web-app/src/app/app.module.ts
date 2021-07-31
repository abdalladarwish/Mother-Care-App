import { BrowserModule } from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import 'flatpickr/dist/flatpickr.css';
import { AppComponent } from './app.component';
import { LoginComponent } from './auth/login/login.component';
import { HeaderComponent } from './header/header.component';
import { HomeComponent } from './home/home.component';
import { SignupComponent } from './auth/signup/signup.component';
import { DoctorListComponent } from './doctor-list/doctor-list.component';
import {ProfileComponent} from './profile/profile.component';
import {NgbModule} from '@ng-bootstrap/ng-bootstrap';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';
import {HttpClientModule} from '@angular/common/http';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import {AppRoutingModule} from './app-routing.module';
import {FlexLayoutModule} from '@angular/flex-layout';
import {LoadingSpinnerComponent} from './shared/loading-spinner/loading-spinner.component';
import {BsDropdownModule} from 'ngx-bootstrap/dropdown';
import { CollapseModule } from 'ngx-bootstrap/collapse';
import { DatepickerModule, BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import {BabyMonitorComponent} from './profile/baby-monitor/baby-monitor.component';
import { TimelineComponent } from './timeline/timeline.component';
import {MatSelectModule} from '@angular/material/select';
import {MatButtonModule} from '@angular/material/button';
import {MatToolbarModule} from '@angular/material/toolbar';
import {MatSidenavModule} from '@angular/material/sidenav';
import {MatIconModule} from '@angular/material/icon';
import {MatListModule} from '@angular/material/list';
import {MatCardModule} from '@angular/material/card';
import {MatCheckboxModule} from '@angular/material/checkbox';
import {MatProgressSpinnerModule} from '@angular/material/progress-spinner';
import {MatGridListModule} from '@angular/material/grid-list';
import {MatTabsModule} from '@angular/material/tabs';
import { CalendarComponent } from './profile/calendar/calendar.component';
import { TempChartComponent } from './profile/baby-monitor/temp-chart/temp-chart.component';
import { RespirChartComponent } from './profile/baby-monitor/respir-chart/respir-chart.component';
import { HeartRateChartComponent } from './profile/baby-monitor/heart-rate-chart/heart-rate-chart.component';
import { MatDialogModule } from '@angular/material/dialog';
import { CalendarModule, DateAdapter } from 'angular-calendar';
import { adapterFactory } from 'angular-calendar/date-adapters/date-fns';
import { CommonModule } from '@angular/common';
import { FlatpickrModule } from 'angularx-flatpickr';
import { NgbModalModule } from '@ng-bootstrap/ng-bootstrap';
import { EventChoiceComponent } from './profile/calendar/event-choice/event-choice.component';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatButtonToggleModule} from '@angular/material/button-toggle';
import { AdditionalInfoComponent } from './auth/additional-info/additional-info.component';
import {UserInfoComponent} from "./profile/user-info/user-info.component";
import { BlogListComponent } from './timeline/blog-list/blog-list.component';
import { BlogComponent } from './timeline/blog-list/blog/blog.component';
import { SideListComponent } from './timeline/side-list/side-list.component';
import { CreateBlogComponent } from './timeline/create-blog/create-blog.component';
import {MatInputModule} from '@angular/material/input';
import { TextEditorComponent } from './timeline/create-blog/text-editor/text-editor.component';
import {QuillModule} from 'ngx-quill';
import {MatPaginatorModule} from '@angular/material/paginator';
import {MatStepperModule} from "@angular/material/stepper";
import {MatRadioModule} from "@angular/material/radio";
import { BlogDetailComponent } from './timeline/blog-list/blog/blog-detail/blog-detail.component';
import { BlogNewTapComponent } from './timeline/blog-list/blog/blog-new-tap/blog-new-tap.component';
import { SavedBlogsComponent } from './timeline/blog-list/saved-blogs/saved-blogs.component';
import { MyBlogsComponent } from './timeline/blog-list/my-blogs/my-blogs.component';
import { AllBlogsComponent } from './timeline/blog-list/all-blogs/all-blogs.component';
import {MatSnackBarModule} from '@angular/material/snack-bar';
import {MatMenuModule} from '@angular/material/menu';
import { LogoutComponent } from './auth/logout/logout.component';
import { CommentComponent } from './timeline/blog-list/blog/blog-detail/comment/comment.component';
import {MatExpansionModule} from '@angular/material/expansion';
import { ListItemsComponent } from './profile/list-items/list-items.component';
import {MatBadge, MatBadgeModule} from '@angular/material/badge';
import {NewBlogsComponent} from './timeline/blog-list/new-blogs/new-blogs.component';
import { ConfirmAccountComponent } from './auth/confirm-account/confirm-account.component';





@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    HeaderComponent,
    HomeComponent,
    SignupComponent,
    DoctorListComponent,
    LoadingSpinnerComponent,
    ProfileComponent,
    BabyMonitorComponent,
    TimelineComponent,
    CalendarComponent,
    TempChartComponent,
    RespirChartComponent,
    HeartRateChartComponent,
    EventChoiceComponent,
    AdditionalInfoComponent,
    UserInfoComponent,
    BlogListComponent,
    BlogComponent,
    SideListComponent,
    CreateBlogComponent,
    TextEditorComponent,
    BlogDetailComponent,
    BlogNewTapComponent,
    SavedBlogsComponent,
    MyBlogsComponent,
    AllBlogsComponent,
    LogoutComponent,
    CommentComponent,
    ListItemsComponent,
    NewBlogsComponent,
    ConfirmAccountComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    NgbModule,
    HttpClientModule,
    BrowserAnimationsModule,
    AppRoutingModule,
    FlexLayoutModule,
    BsDropdownModule.forRoot(),
    CollapseModule.forRoot(),
    BsDatepickerModule.forRoot(),
    DatepickerModule.forRoot(),
    MatButtonModule,
    MatToolbarModule,
    MatSidenavModule,
    MatIconModule,
    MatListModule,
    MatCardModule,
    MatCheckboxModule,
    MatProgressSpinnerModule,
    MatGridListModule,
    MatTabsModule,
    MatDialogModule,
    CommonModule,
    FormsModule,
    NgbModalModule,
    MatCheckboxModule,
    MatRadioModule,
    FlatpickrModule.forRoot(),
    CalendarModule.forRoot({
      provide: DateAdapter,
      useFactory: adapterFactory,
    }),
    MatBadgeModule,
    MatFormFieldModule,
    ReactiveFormsModule,
    MatButtonToggleModule,
    MatSelectModule,
    MatInputModule,
    MatStepperModule,
    MatPaginatorModule,
    MatSnackBarModule,
    MatMenuModule,
    QuillModule.forRoot(),
    MatExpansionModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
