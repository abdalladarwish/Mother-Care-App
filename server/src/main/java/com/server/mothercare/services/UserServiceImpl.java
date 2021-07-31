package com.server.mothercare.services;

import com.server.mothercare.DAOs.UserDAO;
import com.server.mothercare.entities.User;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.util.Optional;

@Service
@Slf4j
@Transactional
public class UserServiceImpl implements UserService {
    private UserDAO userDAO;

    @Autowired
    public UserServiceImpl(UserDAO userDAO){
        this.userDAO = userDAO;
    }

    @Override
    public User registerUser(User theUser) {
        theUser.setUserId(0);
        return this.userDAO.save(theUser);
    }

    @Override
    public Optional<User> getUserbyUserName(String theUserName) throws UsernameNotFoundException{
            Optional<User> optionalUser = userDAO.getUserbyUserName(theUserName);
            optionalUser.orElseThrow(() -> new UsernameNotFoundException("User is not found"));
            return optionalUser;
    }

    @Override
    public User userbyUserName(String theUserName) {
        return userDAO.userbyUserName(theUserName);
    }

    @Override
    public User update(User thUser) {
        return userDAO.save(thUser);
    }

    @Override
    public Optional<User> findUserById(Long id) {
        return userDAO.findById(id);
    }
}
