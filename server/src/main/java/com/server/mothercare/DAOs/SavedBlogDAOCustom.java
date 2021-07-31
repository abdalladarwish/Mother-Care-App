package com.server.mothercare.DAOs;

import com.server.mothercare.entities.User;
import com.server.mothercare.entities.post.Blog;

import java.util.List;

public interface SavedBlogDAOCustom {

    public List<Blog> getUserBommarks(String userName);
}
