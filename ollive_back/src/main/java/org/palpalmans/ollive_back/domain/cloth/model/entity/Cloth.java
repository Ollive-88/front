package org.palpalmans.ollive_back.domain.cloth.model.entity;

import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import org.palpalmans.ollive_back.common.BaseTimeEntity;

import static jakarta.persistence.GenerationType.IDENTITY;
import static lombok.AccessLevel.PROTECTED;

@Entity
@Getter
@Table(name = "cloth")
@NoArgsConstructor(access = PROTECTED)
public class Cloth extends BaseTimeEntity {
    @Id
    @Column(name = "cloth_id")
    @GeneratedValue(strategy = IDENTITY)
    private Long id;

    @Column(name = "cloth_name", length = 255)
    private String name;

    @Column(name = "cloth_brand", length = 100)
    private String brandKor;

    @Column(name = "cloth_brand_english", length = 100)
    private String brandEng;

    @Column(name = "cloth_release_year")
    private Short year;

    @Column(name = "cloth_release_quarter")
    private Byte quarter;

    @Column(name = "cloth_url", length = 255)
    private String clothUrl;

    @Column(name = "cloth_img_url", length = 255)
    private String clothImgUrl;

    @OneToOne
    @PrimaryKeyJoinColumn
    private ClothCategory clothCategory;

    @OneToOne
    @PrimaryKeyJoinColumn
    private ClothSeason clothSeason;

    @OneToOne
    @PrimaryKeyJoinColumn
    private ClothStyle clothStyle;

    @Builder
    public Cloth(String name, String brandKor, String brandEng,
                 Short year, Byte quarter, String clothUrl, String clothImgUrl) {
        this.name = name;
        this.brandKor = brandKor;
        this.brandEng = brandEng;
        this.year = year;
        this.quarter = quarter;
        this.clothUrl = clothUrl;
        this.clothImgUrl = clothImgUrl;
    }
}
