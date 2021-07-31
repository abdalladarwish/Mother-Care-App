package com.server.mothercare.DAOs;

import com.server.mothercare.entities.Image;

import java.util.List;

public interface ImageDAO {
    public boolean save (Image theImage);
    public List<Image> getImages();
}
