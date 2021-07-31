package com.server.mothercare.entities.post;

import com.fasterxml.jackson.annotation.JsonIdentityInfo;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.ObjectIdGenerators;
import com.server.mothercare.entities.Image;
import com.server.mothercare.entities.User;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Entity(name = "Blog")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})
@JsonIdentityInfo(generator = ObjectIdGenerators.IntSequenceGenerator.class, property = "@id")
public class Blog implements Serializable {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;


    @Lob
    @Column(name = "html", length = 16777216)
    private String html;

    @Column(name = "date")
    private Timestamp date;

    @Column(name = "title")
    private String title;

    @Column(name = "fromAdmin")
    private boolean fromAdmin;

    @Column(name = "description")
    private String description;

    @Column(name = "categories")
    private String categories;

    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name = "image_id")
    private Image image;

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "blog")
    private List<Like> likes;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(cascade = CascadeType.ALL)
    private List<Comment> comments;

    public Blog(String html, boolean fromAdmin, Timestamp date, String title, String description, Image image, User user) {
        this.html = html;
        this.date = date;
        this.title = title;
        this.description = description;
        this.image = image;
        this.user = user;
        this.fromAdmin = fromAdmin;
    }

    public Blog() {

    }

    public void addComment(Comment theComment) {
        if (comments == null) {
            comments = new ArrayList<Comment>();
        }
        comments.add(theComment);
//        theComment.setBlog(this);
    }

    public void addLikes(Like theLike) {
        if (likes == null) {
            likes = new ArrayList<Like>();
        }
        likes.add(theLike);
        theLike.setBlog(this);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isFromAdmin() {
        return fromAdmin;
    }

    public void setFromAdmin(boolean fromAdmin) {
        this.fromAdmin = fromAdmin;
    }

    public String getHtml() {
        return html;
    }

    public void setHtml(String text) {
        this.html = text;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCategories() {
        return categories;
    }

    public void setCategories(String categories) {
        this.categories = categories;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Image getImage() {
        return image;
    }

    public void setImage(Image image) {
        this.image = image;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public List<Like> getLikes() {
        return likes;
    }

    public void setLikes(List<Like> likes) {
        this.likes = likes;
    }
}