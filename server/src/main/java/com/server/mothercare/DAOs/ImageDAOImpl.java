package com.server.mothercare.DAOs;

import com.server.mothercare.entities.Image;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
public class ImageDAOImpl implements ImageDAO{
    @Autowired
    private EntityManager entityManager;

    @Override
    public boolean save(Image theImage) {
        Session currentSession = this.entityManager.unwrap(Session.class);
        try {

            currentSession.saveOrUpdate(theImage);
            return true;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }

    }

    @Override
    public List<Image> getImages() {
        Session currentSession = this.entityManager.unwrap(Session.class);
        Query theQuery = currentSession.createQuery("from Image");
        List<Image> images = null;
        try {
            images = theQuery.getResultList();
            return images;
        }catch (Exception e) {
            return null;
        }
    }
}
