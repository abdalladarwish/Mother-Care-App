package com.server.mothercare.entities;

import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.internal.IgnoreForbiddenApisErrors;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import java.sql.Date;

@Embeddable
@Data
@NoArgsConstructor
public class Event {
    @Column(unique = true)
    private Long id;

    @NotNull
    @Column(name = "title")
    private String title;

    @NotNull
    @Column(name = "start_date")
    private Date startDate;

    @Column(name = "end_date")
    private Date endDate;

    @Column(name = "primary_color")
    private String primaryColor;

    @Column(name = "secondary_color")
    private String secondaryColor;

    @Column(name = "reminder")
    private boolean reminder = false;

    @Column(name = "description")
    private String description;

    @Lob
    @Column(name = "image")
    private byte[] image;
}
