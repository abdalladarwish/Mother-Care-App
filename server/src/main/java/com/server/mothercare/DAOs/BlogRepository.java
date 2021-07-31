package com.server.mothercare.DAOs;

import com.server.mothercare.entities.post.Blog;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BlogRepository extends CrudRepository<Blog, Integer>, BlogRepositoryCustom{

}