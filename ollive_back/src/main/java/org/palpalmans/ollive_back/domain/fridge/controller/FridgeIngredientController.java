package org.palpalmans.ollive_back.domain.fridge.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.common.security.details.CustomMemberDetails;
import org.palpalmans.ollive_back.domain.fridge.model.dto.FridgeIngredientDto;
import org.palpalmans.ollive_back.domain.fridge.model.dto.request.FridgeIngredientRequest;
import org.palpalmans.ollive_back.domain.fridge.service.FridgeIngredientService;
import org.palpalmans.ollive_back.domain.fridge.util.UtilMethods;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/fridge-ingredients")
public class FridgeIngredientController {
    private final FridgeIngredientService fridgeIngredientService;

    @GetMapping
    public ResponseEntity<List<FridgeIngredientDto>> getFridgeIngredients(@AuthenticationPrincipal CustomMemberDetails customMemberDetails){
        long memberId = customMemberDetails.getId();

        return ResponseEntity.ok().body(fridgeIngredientService.getFridgeIngredients(memberId));
    }

    @PostMapping
    public ResponseEntity<Long> registerIngredient (
            @AuthenticationPrincipal CustomMemberDetails customMemberDetails,
            @Valid @RequestBody FridgeIngredientRequest request
    ) {
        if(!UtilMethods.isValidLocalDate(request.endAt())){
           throw new RuntimeException("유효하지 않은 날짜 타입입니다");
        }

        long memberId = customMemberDetails.getId();

        return ResponseEntity.ok().body(fridgeIngredientService.registerIngredient(memberId, request));
    }
}
