package com.server.mothercare.services;

import com.server.mothercare.entities.Image;

import java.util.List;

public interface ImageService {
    public Image save (Image theImage);
    public Image update (Image theImage);
    public List<Image> getImages();
}
