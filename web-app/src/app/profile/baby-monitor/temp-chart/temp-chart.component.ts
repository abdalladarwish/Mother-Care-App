import {ChangeDetectorRef, Component, Inject, OnInit, ViewChild} from '@angular/core';
import {Chart} from '../../../../../node_modules/chart.js';
import {DeviceService} from "../../../services/device-service";
import {MAT_DIALOG_DATA, MatDialogRef} from "@angular/material/dialog";
import {Subscription} from "rxjs";

@Component({
  selector: 'app-temp-chart',
  templateUrl: './temp-chart.component.html',
  styleUrls: ['./temp-chart.component.css']
})
export class TempChartComponent implements OnInit {
  myChart : Chart;
  currentChart;
  graphUpdateSubscription : Subscription;
  options = {
    scales: {
      xAxes: [{
        barPercentage: 0.8,
        barThickness: 8,
        maxBarThickness: 10,
        minBarLength: 2,
        gridLines: {
          offsetGridLines: true
        },
        yAxes: [{
          ticks: {
            min: 0,
            max: 50,
            stepSize: 10
          }
        }]
      }],
      layout: {
        padding: {
          left: 50,
          right: 0,
          top: 20,
          bottom: 0
        }
      }
    }
  };
  config = {
    type: 'line',
    data: {
      labels: [],
      datasets: [{
        label: "Temperature",
        borderColor: "rgba(54, 162, 235, 1)",
        fill : false,
        pointBackgroundColor : "rgba(54, 162, 235, 1)",
        pointHoverBorderColor : "rgba(100, 50, 85, 1)",
        pointHoverBackgroundColor : "rgba(54, 162, 235, 1)",
        borderWidth : 1,
        pointRadius : 4,
        pointHoverRadius : 8,
        data: []
      }],
      responsive: true,
      maintainAspectRatio : true,
      options: this.options
    }
  };

  constructor(private sensorService: DeviceService, public dialogRef: MatDialogRef<TempChartComponent>,
              @Inject(MAT_DIALOG_DATA) public data: any, private changeDetector: ChangeDetectorRef) { }

  ngOnInit(): void {
    this.initializeGraph();
    this.graphUpdateSubscription = this.sensorService.getGraphSubject().subscribe((graphNum) => {
      this.initializeGraph();

      if (this.currentChart == graphNum){
        this.myChart.update();
      }
      // let deviceIndex = this.sensorService.monitoringDevices.findIndex(device => device.deviceId == this.data.num);
      // this.currentChart = deviceIndex;
      // if (this.sensorService.monitoringDevices[deviceIndex].tempReads.tempRead.length > 20){
      //   this.config.data.labels = [];
      //   this.config.data.datasets[0].data = [];
      //   this.myChart.update();
      //   this.config.data.labels = this.sensorService.monitoringDevices[deviceIndex].tempReads.readTime.slice(-20).map(time => {
      //     let date = new Date(time);
      //     return date.getHours() + ' : ' + date.getMinutes() + ' : ' + date.getSeconds();
      //   });
      //   this.config.data.datasets[0].data = this.sensorService.monitoringDevices[deviceIndex].tempReads.tempRead.slice(-20);
      //   this.myChart.update();
      // }else {
      //   this.config.data.labels = this.sensorService.monitoringDevices[deviceIndex].tempReads.readTime.map(time => {
      //     let date = new Date(time);
      //     return date.getHours() + ' : ' + date.getMinutes() + ' : ' + date.getSeconds();
      //   });
      //   this.config.data.datasets[0].data = this.sensorService.monitoringDevices[deviceIndex].tempReads.tempRead;
      //   this.myChart.update();
      // }
    });
  }

  initializeGraph(){
    let deviceIndex = this.sensorService.monitoringDevices.findIndex(device => device.deviceId == this.data.num);
    this.currentChart = deviceIndex;
    let yAxis = this.sensorService.monitoringDevices[deviceIndex].tempReads.tempRead;
    let xAxis = this.sensorService.monitoringDevices[deviceIndex].tempReads.readTime;
    if (yAxis.length > 20){
      this.config.data.labels = xAxis.slice(-20).map(time => {
        let date = new Date(time);
        return date.getHours() + ' : ' + date.getMinutes() + ' : ' + date.getSeconds();
      });
      this.config.data.datasets[0].data = yAxis.slice(-20);
    } else {
      this.config.data.labels = xAxis.map(time => {
        let date = new Date(time);
        return date.getHours() + ' : ' + date.getMinutes() + ' : ' + date.getSeconds();
      });
      this.config.data.datasets[0].data = yAxis;
    }
    this.myChart = new Chart('myChart', this.config);
    this.myChart.update();
  }


}
