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
@Table(name = "cloth_category")
@NoArgsConstructor(access = PROTECTED)
public class ClothCategory {
    @Id
    @Column(name = "cloth_id")
    private Long id;

    @Column(name = "super_category")
    String superCategory;

    @Column(name = "sub_category")
    String subCategory;

    @Column(name = "detail_category")
    String detailCategory;
}
