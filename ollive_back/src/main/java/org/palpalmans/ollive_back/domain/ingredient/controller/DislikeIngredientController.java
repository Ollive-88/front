package org.palpalmans.ollive_back.domain.ingredient.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.common.security.details.CustomMemberDetails;
import org.palpalmans.ollive_back.domain.ingredient.model.dto.request.DislikeIngredientRegisterRequest;
import org.palpalmans.ollive_back.domain.ingredient.service.DislikeIngredientService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/dislike-ingredients")
public class DislikeIngredientController {
    private final DislikeIngredientService dislikeIngredientService;

    @PostMapping
    public ResponseEntity<Long> registerDislikeIngredient(
            @AuthenticationPrincipal CustomMemberDetails customMemberDetails,
            @Valid @RequestBody DislikeIngredientRegisterRequest request
    ){
        long memberId = customMemberDetails.getId();

        return ResponseEntity.ok().body(dislikeIngredientService.registerDislikeIngredient(memberId, request));
    }
}
