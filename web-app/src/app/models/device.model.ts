import {HeartRateRead} from "./HeartRateRead";
import {TempRead} from "./TempRead";
import {SPO2Read} from "./SPO2Read";
import {PositionRead} from "./PositionRead";

export class DeviceModel{
  public deviceId : number;
  public babyName : string;
  public heartRateReads : HeartRateRead;
  public tempReads : TempRead;
  public spo2Reads : SPO2Read;
  public positionRead : string;
  public eventSource : EventSource;

  constructor() {
    this.tempReads = new TempRead();
    this.spo2Reads  = new SPO2Read();
    this.heartRateReads = new HeartRateRead();
    this.positionRead = '';
  }
}
