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
public class TempRead implements Comparable<TempRead>{
    private double value;
    private Date time;

    @Override
    public int compareTo(TempRead o) {
        return time.compareTo(o.time);
    }
}
