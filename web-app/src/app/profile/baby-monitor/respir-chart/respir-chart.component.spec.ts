import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RespirChartComponent } from './respir-chart.component';

describe('RespirChartComponent', () => {
  let component: RespirChartComponent;
  let fixture: ComponentFixture<RespirChartComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RespirChartComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(RespirChartComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
