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
@Table(name = "cloth_style")
@NoArgsConstructor(access = PROTECTED)
public class ClothStyle {
    @Id
    @Column(name = "cloth_id")
    private Long id;

    @Column(name = "casual", nullable = false)
    double casual;

    @Column(name = "formal", nullable = false)
    double formal;

    @Column(name = "fancy", nullable = false)
    double fancy;

    @Column(name = "sporty", nullable = false)
    double sporty;

}
