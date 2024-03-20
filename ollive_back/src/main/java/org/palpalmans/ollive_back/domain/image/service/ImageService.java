package org.palpalmans.ollive_back.domain.image.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.image.repository.ImageRepository;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ImageService {
    private final ImageFileService imageFileService;
    private final ImageRepository imageRepository;
}
