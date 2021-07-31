package com.server.mothercare.services;

import com.server.mothercare.entities.post.Blog;
import com.server.mothercare.entities.post.SavedBlog;

import java.util.List;

public interface SavedBlogService {
    public boolean bommarkBlog(SavedBlog savedBlog);
    public boolean unBommarkBlog(SavedBlog savedBlog);
    public List<Blog> userBommarks(String userName);
}
