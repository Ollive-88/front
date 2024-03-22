package org.palpalmans.ollive_back.domain.board.model.dto.request;

import jakarta.validation.constraints.NotBlank;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public record WriteBoardRequest(
        @NotBlank
        String title,
        @NotBlank
        String content,
        List<String> tagNames,
        @RequestPart(required = false)
        List<MultipartFile> images
) {
}
