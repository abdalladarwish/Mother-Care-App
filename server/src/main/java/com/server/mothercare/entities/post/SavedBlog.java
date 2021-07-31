package com.server.mothercare.entities.post;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.server.mothercare.entities.User;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;


@Entity(name = "Savedblog")
@Data
@NoArgsConstructor
public class SavedBlog {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @ManyToOne
    @JoinColumn(name = "blog_id")
    private Blog blog;

}
