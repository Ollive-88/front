package org.palpalmans.ollive_back.domain.fridge.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.fridge.model.dto.FridgeIngredientRequest;
import org.palpalmans.ollive_back.domain.fridge.model.entity.FridgeIngredient;
import org.palpalmans.ollive_back.domain.fridge.repository.FridgeIngredientRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;

@Service
@RequiredArgsConstructor
public class FridgeIngredientService {
    private final FridgeIngredientRepository fridgeIngredientRepository;

    @Transactional
    public Long registerIngredient(long memberId, FridgeIngredientRequest request){
        FridgeIngredient fridgeIngredient = FridgeIngredient.builder()
                .memberId(memberId)
                .name(request.name())
                .endAt(LocalDate.parse(request.endAt()))
                .build();

        return fridgeIngredientRepository.save(fridgeIngredient).getId();
    }
}
