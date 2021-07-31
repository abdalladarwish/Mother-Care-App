package com.server.mothercare.entities.post;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.server.mothercare.entities.Image;
import com.server.mothercare.entities.User;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Entity(name = "Comment")
@JsonIgnoreProperties({"hibernateLazyInitializer", "handler"})public class Comment implements Serializable {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @Column(name = "text")
    private String text;

    @Column(name = "type")
    private String type;

    @Column(name = "date")
    private Timestamp date;

    @Column(name = "blogId")
    private int blogId;


    @OneToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "image_id",referencedColumnName = "id")
    private Image image;


    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(cascade = CascadeType.ALL)
    @JoinColumn(name = "comment_id")
    List<Comment> comments;

    public Comment(String text, String type, Timestamp
            date, User user) {
        this.text = text;
        this.type = type;
        this.date = date;
        this.user = user;
    }
    public  Comment(){

    }
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public int getBlogId() {
        return blogId;
    }

    public void setBlogId(int blogId) {
        this.blogId = blogId;
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

    public void addComment(Comment theComment){
        if (comments == null){
            comments = new ArrayList<Comment>();
        }
        comments.add(theComment);
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", text='" + text + '\'' +
                ", type='" + type + '\'' +
                ", date=" + date +
                ", image=" + image +
                ", user=" + user +
                '}';
    }
}
