package org.palpalmans.ollive_back.domain.image.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

@Service
@RequiredArgsConstructor
public class ImageFileService {
    public String saveImageFile(MultipartFile multipartFiles) {
        return "savedPath";
    }
}
