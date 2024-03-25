package org.palpalmans.ollive_back.domain.cloth.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@Table(name = "cloth_season")
@NoArgsConstructor(access = PROTECTED)
public class ClothSeason {
    @Id
    @Column(name = "cloth_id")
    private Long id;

    @Column(name = "spring", columnDefinition = "TINYINT(1)")
    private boolean spring;

    @Column(name = "summer", columnDefinition = "TINYINT(1)")
    private boolean summer;

    @Column(name = "fall", columnDefinition = "TINYINT(1)")
    private boolean fall;

    @Column(name = "winter", columnDefinition = "TINYINT(1)")
    private boolean winter;

}
