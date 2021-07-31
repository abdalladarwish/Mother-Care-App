package com.server.mothercare.DAOs;

import com.server.mothercare.entities.User;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface UserDAO extends CrudRepository<User, Long>, UserDAOCustom {
    Optional<User> findByUsername(String username);
}

