package com.server.mothercare.entities.kit;
import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.server.mothercare.entities.User;

import com.server.mothercare.models.kit.HeartRateRead;
import com.server.mothercare.models.kit.SPO2Read;
import com.server.mothercare.models.kit.TempRead;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import javax.persistence.*;
import java.util.List;

@Entity
@Data
@Table(name = "monitoring_device")
@NoArgsConstructor
public class MonitoringDevice {

    @Id
    private Long deviceId;

    @Column(name = "baby_name")
    private String babyName;

    @Column(name = "temp_issue_flag")
    private boolean tempIssueFlag;

    @Column(name = "heartrate_issue_flag")
    private boolean heartrateIssueFlag;

    @Column(name = "spo2_issue_flag")
    private boolean spo2IssueFlag;


    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(
            name = "temperature_reads",
            joinColumns = @JoinColumn(name = "deviceId")
    )
    @Fetch(value = FetchMode.SUBSELECT)
    private List<TempRead> tempReads;

    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(
            name = "heartrate_reads",
            joinColumns = @JoinColumn(name = "deviceId")
    )
    @Fetch(value = FetchMode.SUBSELECT)
    private List<HeartRateRead> heartRateReads;


    @ElementCollection(fetch = FetchType.EAGER)
    @CollectionTable(
            name = "spo2_reads",
            joinColumns = @JoinColumn(name = "deviceId")
    )
    @Fetch(value = FetchMode.SUBSELECT)
    private List<SPO2Read> spo2Reads;

    @ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "user_id", referencedColumnName = "userId")
    private User user;

    public MonitoringDevice(Long id, User deviceUser){
        deviceId = id;
        user = deviceUser;
    }

    public MonitoringDevice(Long id){
        deviceId = id;
    }
}
