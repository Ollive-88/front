package org.palpalmans.ollive_back.domain.image.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.image.model.ImageType;
import org.palpalmans.ollive_back.domain.image.model.entity.Image;
import org.palpalmans.ollive_back.domain.image.repository.ImageRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ImageService {
    private final ImageFileService imageFileService;
    private final ImageRepository imageRepository;

    @Transactional
    public void saveImage(List<MultipartFile> images, ImageType imageType, Long referenceId) {
        images.forEach(image -> {
            String address = imageFileService.saveImageFile(image);
            imageRepository.save(new Image(address, imageType, referenceId));
        });
    }
}
