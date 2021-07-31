package com.server.mothercare.services;

import com.server.mothercare.entities.post.Like;

import java.util.Optional;

public interface LikeService {
    public Like save(Like theLike);
    public Like update(Like theLike);
    public Optional<Like> getLikeById(int theId);
    public boolean deleteLike(int theId);


}
