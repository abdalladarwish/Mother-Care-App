import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BlogNewTapComponent } from './blog-new-tap.component';

describe('BlogNewTapComponent', () => {
  let component: BlogNewTapComponent;
  let fixture: ComponentFixture<BlogNewTapComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BlogNewTapComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(BlogNewTapComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
