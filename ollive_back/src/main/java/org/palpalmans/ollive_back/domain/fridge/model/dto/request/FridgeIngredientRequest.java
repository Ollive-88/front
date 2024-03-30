package org.palpalmans.ollive_back.domain.fridge.model.dto.request;

import jakarta.validation.constraints.NotBlank;

public record FridgeIngredientRequest(
        @NotBlank
        String name,
        @NotBlank
        String endAt
) {
}
