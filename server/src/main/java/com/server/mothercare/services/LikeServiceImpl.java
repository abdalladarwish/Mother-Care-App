package com.server.mothercare.services;

import com.server.mothercare.DAOs.LikeRepository;
import com.server.mothercare.entities.post.Like;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

@Service
@Transactional
public class LikeServiceImpl implements LikeService{

    LikeRepository likeRepository;

    @Autowired
    public LikeServiceImpl(LikeRepository likeRepository){
        this.likeRepository = likeRepository;
    }

    @Override
    public Like save(Like theLike) {
        theLike.setId(0);
        return likeRepository.save(theLike);
    }

    @Override
    public Like update(Like theLike) {
        return likeRepository.save(theLike);
    }

    @Override
    public Optional<Like> getLikeById(int theId) {
        return likeRepository.findById(theId);
    }

    @Override
    public boolean deleteLike(int theId) {
        boolean deleted = false;
        try {
            likeRepository.deleteById(theId);
            deleted = true;
        }catch (Exception e){
            e.printStackTrace();
        }
        return deleted;
    }
}
