package org.palpalmans.ollive_back.domain.recipe.model.entity;

import static jakarta.persistence.FetchType.*;
import static jakarta.persistence.GenerationType.*;
import static lombok.AccessLevel.*;

import com.fasterxml.jackson.annotation.JsonBackReference;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Getter;
import lombok.NoArgsConstructor;

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
    @JsonBackReference
    private Ingredient ingredient;

    @ManyToOne(fetch = LAZY)
    @JoinColumn(name = "recipe_id", nullable = false)
    @JsonBackReference
    private Recipe recipe;
}
