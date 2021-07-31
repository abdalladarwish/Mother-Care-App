package com.server.mothercare.DAOs;

import com.server.mothercare.entities.kit.MonitoringDevice;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DeviceDAO extends CrudRepository<MonitoringDevice, Long> {
}
