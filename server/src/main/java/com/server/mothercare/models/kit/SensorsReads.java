package com.server.mothercare.models.kit;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SensorsReads {
    private TempRead tempRead;
    private SPO2Read spo2Read;
    private HeartRateRead heartRateRead;
    private String  positionRead;
}
