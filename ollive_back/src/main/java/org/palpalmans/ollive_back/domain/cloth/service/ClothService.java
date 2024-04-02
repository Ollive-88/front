package org.palpalmans.ollive_back.domain.cloth.service;

import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.palpalmans.ollive_back.domain.cloth.config.FastApiProperties;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.ClothRecommendationRequest;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.ClothRecommendationRequestToData;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.WeatherRequest;
import org.palpalmans.ollive_back.domain.cloth.model.dto.response.ClothRecommendationResponse;
import org.palpalmans.ollive_back.domain.cloth.model.dto.response.ClothResponse;
import org.palpalmans.ollive_back.domain.cloth.model.dto.response.GetClothesResponse;
import org.palpalmans.ollive_back.domain.cloth.model.entity.Cloth;
import org.palpalmans.ollive_back.domain.cloth.model.entity.ClothMember;
import org.palpalmans.ollive_back.domain.cloth.respository.ClothRepository;
import org.palpalmans.ollive_back.domain.member.model.entity.Member;
import org.springframework.boot.web.client.ClientHttpRequestFactories;
import org.springframework.boot.web.client.ClientHttpRequestFactorySettings;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestClient;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.palpalmans.ollive_back.common.error.ErrorMessage.BOARD_NOT_FOUND;

@Slf4j
@Service
@RequiredArgsConstructor
public class ClothService {
    private final WeatherService weatherService;
    private final FastApiProperties fastApiProperties;
    private final ClothRepository clothRepository;
    private final ClothMemberService clothMemberService;

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

    @Transactional
    public void seenCloth(Long clothId, Member member) {

        Cloth cloth = clothRepository.findById(clothId).orElseThrow(() -> new EntityNotFoundException("옷을 찾을 수 없습니다."));

        Optional<ClothMember> clothMember = clothMemberService.findClothMember(cloth, member);
        if(!clothMember.isPresent()){
            clothMemberService.saveClothMember(cloth, member);
        }
    }

    public GetClothesResponse getSeenCloth(Member member) {
        List<ClothMember> clothMembers = clothMemberService.getSeenCloth(member);

        List<ClothResponse> clothResponses = new ArrayList<>();

        for(ClothMember clothMember : clothMembers){
            Cloth cloth = clothMember.getCloth();
            clothResponses.add(ClothResponse.builder()
                            .id(cloth.getId())
                            .rank(0)
                            .productName(cloth.getProductName())
                            .brand(cloth.getBrand())
                            .brandEnglish(cloth.getBrandEnglish())
                            .productUrl(cloth.getProductUrl())
                            .imgUrl(cloth.getImgUrl())
                    .build());
        }

        return new GetClothesResponse(clothResponses);
    }
}