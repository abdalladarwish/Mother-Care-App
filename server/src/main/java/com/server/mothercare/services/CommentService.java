package com.server.mothercare.services;


import com.server.mothercare.entities.post.Comment;

public interface CommentService {
    public Comment save(Comment theComment);
    public Comment update(Comment theComment);
    public Comment getCommentById(int theId);


}
