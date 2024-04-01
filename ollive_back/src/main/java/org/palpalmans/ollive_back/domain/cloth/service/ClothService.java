package org.palpalmans.ollive_back.domain.cloth.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.cloth.config.FastApiProperties;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.ClothRecommendationRequest;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.ClothRecommendationRequestToData;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.WeatherRequest;
import org.palpalmans.ollive_back.domain.cloth.model.dto.response.ClothRecommendationResponse;
import org.springframework.boot.web.client.ClientHttpRequestFactories;
import org.springframework.boot.web.client.ClientHttpRequestFactorySettings;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestClient;

import java.time.Duration;

@Slf4j
@Service
@RequiredArgsConstructor
public class ClothService {
    private final WeatherService weatherService;
    private final FastApiProperties fastApiProperties;

    public ClothRecommendationResponse recommendCloth(ClothRecommendationRequest clothRecommendationRequest) {
        WeatherRequest weatherRequest = clothRecommendationRequest.extractWeatherRequest();
        double temperature = weatherService.getTemperatureFromKMA(weatherRequest);
        log.info("현재 기온: {}", temperature);

        return doRecommend(new ClothRecommendationRequestToData(
                clothRecommendationRequest.text(),
                temperature));
    }

    public ClothRecommendationResponse doRecommend(ClothRecommendationRequestToData clothRecommendationRequestToData) {
        RestClient restClient = RestClient
                .builder()
                .baseUrl(fastApiProperties.getBaseUrl())
                .requestFactory(ClientHttpRequestFactories
                        .get(ClientHttpRequestFactorySettings.DEFAULTS
                                .withConnectTimeout(Duration.ofSeconds(15))
                                .withReadTimeout(Duration.ofSeconds(15))))
                .build();

        return restClient
                .post()
                .uri("/cloth/recommendation")
                .body(clothRecommendationRequestToData)
                .retrieve()
                .body(ClothRecommendationResponse.class);
    }
}