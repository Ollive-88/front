package org.palpalmans.ollive_back.domain.cloth.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.ClothRecommendationRequest;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.WeatherRequest;
import org.palpalmans.ollive_back.domain.cloth.model.dto.response.ClothRecommendationResponse;
import org.palpalmans.ollive_back.domain.cloth.model.dto.response.ClothResponse;
import org.palpalmans.ollive_back.domain.cloth.model.entity.Cloth;
import org.palpalmans.ollive_back.domain.cloth.respository.ClothRepository;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class ClothService {
    private final WeatherService weatherService;
    private final ClothRepository clothRepository;

    public ClothRecommendationResponse recommendCloth(ClothRecommendationRequest clothRecommendationRequest) throws Exception {
        String text = clothRecommendationRequest.text();

        WeatherRequest weatherRequest = clothRecommendationRequest.extractWeatherRequest();
        double temperature = weatherService.getTemperatureFromKMA(weatherRequest);

        long before = System.currentTimeMillis();

        List<Cloth> clothList = clothRepository.findAll();

        long after = System.currentTimeMillis();
        log.info("쿼리 호출에 걸린 시간: {}ms", (after - before));

        return new ClothRecommendationResponse(
                doRecommend("아우터", text, temperature),
                doRecommend("상의", text, temperature),
                doRecommend("하의", text, temperature),
                doRecommend("신발", text, temperature));
    }
    public List<ClothResponse> doRecommend(String categoryOfCloth, String text, double temperature) {
        return new ArrayList<>();
    }
}