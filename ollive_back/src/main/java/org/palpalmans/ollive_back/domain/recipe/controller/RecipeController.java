package org.palpalmans.ollive_back.domain.recipe.controller;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.recipe.service.RecipeService;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
public class RecipeController {
    private final RecipeService recipeService;


}
