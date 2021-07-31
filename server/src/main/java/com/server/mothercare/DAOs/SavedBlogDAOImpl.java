package com.server.mothercare.DAOs;

import com.server.mothercare.entities.post.Blog;
import com.server.mothercare.entities.post.SavedBlog;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.ArrayList;
import java.util.List;

@Repository
public class SavedBlogDAOImpl implements SavedBlogDAOCustom {
    @Autowired
    private EntityManager entityManager;

    @Override
    public List<Blog> getUserBommarks(String userName) {
        Session currentSession = this.entityManager.unwrap(Session.class);

        List<Blog> blogs = new ArrayList<Blog>();
        Query theQuery = currentSession.createQuery("from Savedblog where user.username=:userName");
        try {
            List<SavedBlog> savedBlogs = (List<SavedBlog>) theQuery.setParameter("userName", userName).getResultList();
            System.out.println("kimooooooooooooooooooooooooooooooooooooooooooooo :" + userName + " , " + savedBlogs.toArray().length);
            for (SavedBlog savedBlog : savedBlogs) {
                blogs.add(savedBlog.getBlog());
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return blogs;
    }
}
