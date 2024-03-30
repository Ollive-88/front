package org.palpalmans.ollive_back.domain.fridge.model.dto;

public record FridgeIngredientDto(
    Long fridgeIngredientId,
    String name,
    String endAt
) {
}
