package org.palpalmans.ollive_back.domain.recipe.model.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

import static jakarta.persistence.GenerationType.IDENTITY;
import static lombok.AccessLevel.PROTECTED;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Getter
@NoArgsConstructor(access = PROTECTED)
public class Ingredient {
    @Id
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    @Column(length = 20)
    private String name;

    @OneToMany(mappedBy = "ingredient")
    @JsonManagedReference
    private List<RecipeIngredient> recipeIngredients = new ArrayList<>();

}
