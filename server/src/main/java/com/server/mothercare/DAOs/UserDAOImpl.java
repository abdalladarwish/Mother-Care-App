package com.server.mothercare.DAOs;

import com.server.mothercare.entities.User;
import com.server.mothercare.entities.kit.MonitoringDevice;
import org.hibernate.Session;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import javax.persistence.EntityManager;
import java.util.List;
import java.util.Optional;

@Repository
public class UserDAOImpl implements UserDAOCustom {

    private EntityManager entityManager;

    @Autowired
    public UserDAOImpl(EntityManager entityManager) {
        this.entityManager = entityManager;
    }

    @Override
    public User userbyUserName(String theUserName) {
        Session currentSession = this.entityManager.unwrap(Session.class);
        Query query = currentSession.createQuery(" from User where username=:theUserName");
        User user = null;
        try {
            user = (User) query.setParameter("theUserName", theUserName).getResultList().get(0);
            return user;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }

    @Override
    public Optional<User> getUserbyUserName(String theUserName) {
        Session currentSession = this.entityManager.unwrap(Session.class);
        Query query = currentSession.createQuery(" from User where username=:theUserName");
        User user = null;
        try {
            user = (User) query.setParameter("theUserName", theUserName).getResultList().get(0);
            return Optional.of(user);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return Optional.ofNullable(null);
        }
    }

    @Override
    public Optional<List<MonitoringDevice>> getUserDevices(String username) {
        Session currentSession = this.entityManager.unwrap(Session.class);
        Query query = currentSession.createQuery(" from MonitoringDevice where user.username=:username");
        List<MonitoringDevice> userDevices = null;
        try {
            userDevices = (List<MonitoringDevice>) query.setParameter("username", username).getResultList().get(0);
            return Optional.of(userDevices);
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return Optional.ofNullable(null);
        }
    }


}
