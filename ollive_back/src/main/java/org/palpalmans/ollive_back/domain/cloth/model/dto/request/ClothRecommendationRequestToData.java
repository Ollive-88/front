package org.palpalmans.ollive_back.domain.cloth.model.dto.request;

public record ClothRecommendationRequestToData(
        String text,
        double temperature
) {
}
