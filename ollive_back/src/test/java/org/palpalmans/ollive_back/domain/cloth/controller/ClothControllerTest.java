package org.palpalmans.ollive_back.domain.cloth.controller;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import org.palpalmans.ollive_back.domain.cloth.model.dto.request.ClothRecommendationRequest;
import org.palpalmans.ollive_back.domain.cloth.service.ClothService;

@ExtendWith(MockitoExtension.class)
public class ClothControllerTest {
    @InjectMocks
    private ClothController clothController;
    @Mock
    private ClothService clothService;

    @BeforeEach
    void setUp() {
    }


    @Test
    public void recommendClothTest() { // given, when, then
        ClothRecommendationRequest clothRecommendationRequest = new ClothRecommendationRequest(
                "Test", 37.56356, 126.98);
    }


}
