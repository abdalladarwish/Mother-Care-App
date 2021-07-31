package com.server.mothercare.DAOs;

import com.server.mothercare.entities.User;
import com.server.mothercare.entities.kit.MonitoringDevice;

import java.util.List;
import java.util.Optional;

public interface UserDAOCustom {
    public User userbyUserName(String theUserName);
    public Optional<User> getUserbyUserName(String theUserName);
    public Optional<List<MonitoringDevice>> getUserDevices(String username);
}
