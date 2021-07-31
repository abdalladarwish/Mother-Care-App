import { ComponentFixture, TestBed } from '@angular/core/testing';

import { HeartRateChartComponent } from './heart-rate-chart.component';

describe('HeartRateChartComponent', () => {
  let component: HeartRateChartComponent;
  let fixture: ComponentFixture<HeartRateChartComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ HeartRateChartComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(HeartRateChartComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
