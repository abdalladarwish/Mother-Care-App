package com.server.mothercare.services;

import com.server.mothercare.DAOs.SavedBlogDAO;
import com.server.mothercare.entities.post.Blog;
import com.server.mothercare.entities.post.SavedBlog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class SavedBlogServiceImpl implements SavedBlogService{

    private SavedBlogDAO savedBlogDAO;

    @Autowired
    public SavedBlogServiceImpl(SavedBlogDAO savedBlogDAO){
        this.savedBlogDAO = savedBlogDAO;
    }

    @Override
    public boolean bommarkBlog(SavedBlog savedBlog) {
        boolean saved = false;
        try {
            savedBlog.setId(0);
            savedBlogDAO.save(savedBlog);
            saved = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return saved;
    }

    @Override
    public boolean unBommarkBlog(SavedBlog savedBlog) {
        boolean deleted = false;
        try {
            savedBlogDAO.delete(savedBlog);
            deleted = true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return deleted;
    }

    @Override
    @Transactional
    public List<Blog> userBommarks(String userName) {
        return savedBlogDAO.getUserBommarks(userName);
    }
}
