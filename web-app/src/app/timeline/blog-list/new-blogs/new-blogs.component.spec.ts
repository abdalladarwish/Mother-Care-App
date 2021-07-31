import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NewBlogsComponent } from './new-blogs.component';

describe('NewBlogsComponent', () => {
  let component: NewBlogsComponent;
  let fixture: ComponentFixture<NewBlogsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NewBlogsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NewBlogsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
