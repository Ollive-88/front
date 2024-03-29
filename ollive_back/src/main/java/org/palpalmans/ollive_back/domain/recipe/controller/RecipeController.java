package org.palpalmans.ollive_back.domain.recipe.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.common.security.details.CustomMemberDetails;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeDto;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeSummaryDto;
import org.palpalmans.ollive_back.domain.recipe.model.dto.request.RecipeRecommendRequest;
import org.palpalmans.ollive_back.domain.recipe.model.dto.request.RecipeScoreRequest;
import org.palpalmans.ollive_back.domain.recipe.model.dto.request.RecipeSearchRequest;
import org.palpalmans.ollive_back.domain.recipe.service.RecipeRecommendService;
import org.palpalmans.ollive_back.domain.recipe.service.RecipeService;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/recipes")
@Validated
public class RecipeController {
    private final RecipeService recipeService;
    private final RecipeRecommendService recipeRecommendService;

    @GetMapping("/{recipeId}")
    public ResponseEntity<RecipeDto> getRecipe(@PathVariable Long recipeId) {
        return ResponseEntity.ok().body(recipeService.getRecipe(recipeId));
    }

    @PostMapping
    public ResponseEntity<List<RecipeSummaryDto>> getRecipesByCategory(@Valid @RequestBody RecipeSearchRequest recipeSearchRequest) {
        return ResponseEntity.ok().body(recipeService.getRecipesByCategory(recipeSearchRequest));
    }

    @PostMapping("/scores")
    public ResponseEntity<Integer> generateOrUpdateScore(
            @Valid @RequestBody RecipeScoreRequest recipeScoreRequest,
            @AuthenticationPrincipal CustomMemberDetails customMemberDetails
    ) {
        Long memberId = customMemberDetails.getId();
        return ResponseEntity.ok().body(recipeService.generateOrUpdateScore(memberId, recipeScoreRequest));
    }

    @PostMapping("/recommendations")
    public ResponseEntity<?> recommendRecipes(@Valid @RequestBody RecipeRecommendRequest request){
        List<RecipeSummaryDto> recommendCandidates = recipeRecommendService.getRecommendCandidates(request);

        if (recommendCandidates.size() <= 10){
            return ResponseEntity.ok().body(recommendCandidates);
        }else{
            return ResponseEntity.ok().body(recommendCandidates.subList(0, 10));
        }
    }
}
