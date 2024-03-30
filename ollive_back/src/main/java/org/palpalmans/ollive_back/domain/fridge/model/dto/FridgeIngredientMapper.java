package org.palpalmans.ollive_back.domain.fridge.model.dto;

import org.palpalmans.ollive_back.domain.fridge.model.entity.FridgeIngredient;

public class FridgeIngredientMapper {
    public static FridgeIngredientDto toFridgeIngredientDto(FridgeIngredient fridgeIngredient) {
        return new FridgeIngredientDto(fridgeIngredient.getId(), fridgeIngredient.getName(), fridgeIngredient.getEndAt().toString());
    }
}
