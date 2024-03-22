package org.palpalmans.ollive_back.domain.recipe.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static jakarta.persistence.FetchType.LAZY;
import static jakarta.persistence.GenerationType.IDENTITY;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@NoArgsConstructor(access = PROTECTED)
public class RecipeIngredient {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    @Column(length = 255)
    private String amount;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "ingredient_id", nullable = false)
    private Ingredient ingredient;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "recipe_id", nullable = false)
    private Recipe recipe;
}
