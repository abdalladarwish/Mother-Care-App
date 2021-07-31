package com.server.mothercare.DAOs;

import com.server.mothercare.entities.post.Blog;
import com.server.mothercare.entities.post.Like;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Repository
public class BlogRepositoryImpl implements BlogRepositoryCustom {
    @Autowired
    private EntityManager entityManager;

    @Override
    public List<Blog> getBlogs(int currentId, String author, String category) {
        Session currentSession = this.entityManager.unwrap(Session.class);
        List<Blog> blogs = null;
        System.out.println("here " );
        Query theQuery;
        if (currentId == 0){
            if ( author.equals("mother-care")){
                if(category.equals("all")) {
                    theQuery = currentSession.createQuery("from Blog where user.username=:author ORDER BY id DESC ")
                            .setParameter("author",author);
                } else {
                    theQuery = currentSession.createQuery("from Blog where (user.username=:author and categories LIKE:category )ORDER BY id DESC ")
                            .setParameter("author",author).setParameter("category", "%"+ category+"%");
                }
            } else {
                if (category.equals("all")) {
                    theQuery = currentSession.createQuery("from Blog ORDER BY id DESC ");
                } else {
                    theQuery = currentSession.createQuery("from Blog where categories LIKE:category ORDER BY id DESC")
                            .setParameter("category", "%"+ category+"%");
                }
            }

        } else {
            if ( author.equals("mother-care")){
                 if (category.equals("all")) {
                     theQuery = currentSession.createQuery("from Blog where (id<:currentId and user.username=:author) ORDER BY id DESC ")
                             .setParameter("currentId",currentId).setParameter("author",author);
                 } else {
                     theQuery = currentSession.createQuery("from Blog where (id<:currentId and user.username=:author and categories LIKE:category)" +
                             " ORDER BY id DESC ").setParameter("currentId", currentId).setParameter("category", "%"+ category+"%")
                             .setParameter("author", author);
                 }

            } else {
                if (category.equals("all")) {
                    theQuery = currentSession.createQuery("from Blog where id<:currentId ORDER BY id DESC ")
                            .setParameter("currentId", currentId);
                } else {
                    theQuery = currentSession.createQuery("from Blog where (id<:currentId and categories LIKE:category)ORDER BY id DESC ")
                            .setParameter("currentId", currentId).setParameter("category", "%" + category + "%");
                }
            }
        }

        try {
            blogs = theQuery.setMaxResults(12).getResultList();

        }catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return blogs;
    }

    @Override
    public List<Blog> getUserBlogs(String author) {
        Session currentSession = this.entityManager.unwrap(Session.class);
        List<Blog> blogs = null;
        Query theQuery = currentSession.createQuery("from Blog  where user.username=:author");
        try{
            blogs = theQuery.setParameter("author", author).getResultList();
        } catch (Exception e){
            System.out.println(e.getMessage());
        }
        return blogs;
    }

    @Override
    public long blogsCount(String author, String category) {
        Session currentSession = this.entityManager.unwrap(Session.class);
        long count = 0;
        Query theQuery;
        if (author.equals("mother-care")) {
            if (category.equals("all")) {
                theQuery = currentSession.createQuery("select count(*) from Blog where user.username =: author")
                        .setParameter("author", author);
            } else {
                theQuery = currentSession.createQuery("select count(*) from Blog where user.username =: author and categories LIKE:category").
                        setParameter("author", author).setParameter("category", "%" + category + "%");
            }
        } else {
            if (category.equals("all")) {
                theQuery = currentSession.createQuery("select count(*) from Blog");
            } else {
                theQuery = currentSession.createQuery("select count(*) from Blog where categories LIKE:category")
                        .setParameter("category", "%" + category + "%");
            }
        }

        try {
            count = (long)theQuery.getSingleResult();
        } catch (Exception e) {
            System.out.printf(e.getMessage());
        }
        return count;
    }

    @Override
    public List<Blog> getLikedBlogs(String userName) {
        Session currentSession = this.entityManager.unwrap(Session.class);
        List<Blog> blogs = new ArrayList<Blog>();
        Query theQuery = currentSession.createQuery("from Likes where user.username=:userName");
        try{
            List<Like> likes = (List<Like>) theQuery.setParameter("userName",userName).getResultList();
            for( Like like: likes ){
                blogs.add(like.getBlog());
            }

        } catch (Exception e){
            System.out.println(e.getMessage());
            blogs = null;
        }
        return blogs;
    }

}
