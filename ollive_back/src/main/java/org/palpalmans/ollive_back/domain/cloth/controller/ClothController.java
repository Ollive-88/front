package org.palpalmans.ollive_back.domain.cloth.controller;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.ClothRecommendationRequest;
import org.palpalmans.ollive_back.domain.cloth.model.dto.response.ClothRecommendationResponse;
import org.palpalmans.ollive_back.domain.cloth.service.ClothService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/cloth")
public class ClothController {
    private final ClothService clothService;

    @PostMapping("/recommendation")
    public ResponseEntity<ClothRecommendationResponse> recommendCloth(ClothRecommendationRequest clothRecommendationRequest) throws Exception {
        log.info("text: {}", clothRecommendationRequest.text());
        log.info("latitude: {}", clothRecommendationRequest.latitude());
        log.info("longitude: {}", clothRecommendationRequest.longitude());
        return ResponseEntity.ok(clothService.recommendCloth(clothRecommendationRequest));
    }
}
