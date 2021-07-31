package com.server.mothercare.services;

import com.server.mothercare.DAOs.BlogRepository;
import com.server.mothercare.entities.post.Blog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class BlogServiceImpl implements BlogService{
    @Autowired
    private BlogRepository blogRepository;

    @Override
    public Blog save(Blog theBlog) {
        theBlog.setId(0);
        return blogRepository.save(theBlog);
    }

    @Override
    public Blog update(Blog theBlog) {
        return blogRepository.save(theBlog);
    }

    @Override
    public void deleteById(int theId) {
        blogRepository.deleteById(theId);
    }


    @Override
    public List<Blog> getBlogs(int cycle, String user, String category) {
        return blogRepository.getBlogs(cycle, user, category);
    }

    @Override
    public Blog getBlogById(int theId) {
        Optional<Blog> output = blogRepository.findById(theId);
        Blog blog = null ;
        if (output.isPresent()){
            blog = output.get();
        }
        return  blog;
    }

    @Override
    public List<Blog> getUserBlogs(String userName) {

        return blogRepository.getUserBlogs(userName);
    }

    @Override
    public long blogsCount(String author, String category) {
        return blogRepository.blogsCount(author, category);
    }

    @Override
    public List<Blog> getLikedBlogs(String userName) {
        return blogRepository.getLikedBlogs(userName);
    }

}
