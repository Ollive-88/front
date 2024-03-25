package org.palpalmans.ollive_back.domain.cloth.model.dto.response;

import java.util.List;

public record ClothRecommendationResponse(
        List<ClothResponse> outerList,
        List<ClothResponse> topList,
        List<ClothResponse> bottomList,
        List<ClothResponse> shoesList
) {

}