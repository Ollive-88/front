package org.palpalmans.ollive_back.domain.recipe.controller;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeDto;
import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeSummaryDto;
import org.palpalmans.ollive_back.domain.recipe.model.dto.request.RecipeSearchRequest;
import org.palpalmans.ollive_back.domain.recipe.service.RecipeService;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/recipes")
@Validated
public class RecipeController {
    private final RecipeService recipeService;

    @GetMapping("/{recipeId}")
    public ResponseEntity<RecipeDto> getRecipe(@PathVariable Long recipeId) {
        return ResponseEntity.ok().body(recipeService.getRecipe(recipeId));
    }

    @PostMapping
    public ResponseEntity<List<RecipeSummaryDto>> getRecipesByCategory(@Valid @RequestBody RecipeSearchRequest recipeSearchRequest) {
        return ResponseEntity.ok().body(recipeService.getRecipesByCategory(recipeSearchRequest));
    }

}
