package com.server.mothercare.models.kit;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Embeddable;
import java.util.Date;

@Embeddable
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SPO2Read implements Comparable<SPO2Read>{
    private double value;
    private Date time;

    @Override
    public int compareTo(SPO2Read o) {
        return time.compareTo(o.time);
    }
}
