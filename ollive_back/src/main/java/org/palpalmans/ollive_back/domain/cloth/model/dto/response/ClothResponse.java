package org.palpalmans.ollive_back.domain.cloth.model.dto.response;

public record ClothResponse(
        String name,
        String category,
        String url,
        String imgPath
) {
}
