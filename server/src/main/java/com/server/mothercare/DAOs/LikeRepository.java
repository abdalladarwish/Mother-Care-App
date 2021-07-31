package com.server.mothercare.DAOs;

import com.server.mothercare.entities.post.Like;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface LikeRepository extends CrudRepository<Like, Integer> {

}
