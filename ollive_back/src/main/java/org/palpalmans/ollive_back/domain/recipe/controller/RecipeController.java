package org.palpalmans.ollive_back.domain.recipe.controller;

import org.palpalmans.ollive_back.domain.recipe.model.dto.RecipeDetailDto;
import org.palpalmans.ollive_back.domain.recipe.service.RecipeService;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.validation.constraints.Positive;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/recipes")
@Validated
public class RecipeController {
    private final RecipeService recipeService;

    @GetMapping("/{recipeId}")
    public ResponseEntity<RecipeDetailDto> getRecipe(@PathVariable @Positive Long recipeId) {
        return ResponseEntity.ok().body(recipeService.getRecipe(recipeId));
    }
}
