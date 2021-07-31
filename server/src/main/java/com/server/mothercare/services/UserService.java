package com.server.mothercare.services;

import com.server.mothercare.entities.User;

import java.util.Optional;

public interface UserService {
    public User registerUser(User theUser);

    public Optional<User> getUserbyUserName(String theUserName);

    public User userbyUserName(String theUserName);

    public User update(User thUser);
    public Optional<User> findUserById(Long id);
}

