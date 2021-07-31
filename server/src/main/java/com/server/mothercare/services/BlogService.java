package com.server.mothercare.services;


import com.server.mothercare.entities.User;
import com.server.mothercare.entities.post.Blog;
import com.server.mothercare.entities.post.SavedBlog;

import java.util.List;

public interface BlogService {
    public Blog save(Blog theBlog);
    public Blog update(Blog theBlog);
    public void deleteById(int theId);
    public List<Blog> getBlogs(int cycle, String author, String category);
    public Blog getBlogById(int theId);
    public List<Blog> getUserBlogs(String userName);
    public List<Blog> getLikedBlogs(String userName);
    public long blogsCount(String author, String category);

}
