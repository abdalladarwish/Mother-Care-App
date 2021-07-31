package com.server.mothercare.DAOs;

import com.server.mothercare.entities.post.SavedBlog;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SavedBlogDAO extends CrudRepository<SavedBlog,Long>, SavedBlogDAOCustom {
}
