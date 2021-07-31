package com.server.mothercare.services;

import com.server.mothercare.DAOs.ImageRepository;
import com.server.mothercare.entities.Image;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class ImageServiceImpl implements ImageService{

    @Autowired
    private ImageRepository imageRepository;

    @Override
    public Image save(Image theImage) {
        theImage.setId(0);
        return imageRepository.save(theImage);
    }

    @Override
    public Image update(Image theImage) {
        return imageRepository.save(theImage);
    }

    @Override
    public List<Image> getImages() {
        return (List<Image>) imageRepository.findAll();
    }
}
