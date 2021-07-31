import { ComponentFixture, TestBed } from '@angular/core/testing';

import { EventChoiceComponent } from './event-choice.component';

describe('EventChoiceComponent', () => {
  let component: EventChoiceComponent;
  let fixture: ComponentFixture<EventChoiceComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ EventChoiceComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(EventChoiceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
