package org.palpalmans.ollive_back.domain.cloth.model.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QCloth is a Querydsl query type for Cloth
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QCloth extends EntityPathBase<Cloth> {

    private static final long serialVersionUID = -658243946L;

    public static final QCloth cloth = new QCloth("cloth");

    public final org.palpalmans.ollive_back.common.QBaseTimeEntity _super = new org.palpalmans.ollive_back.common.QBaseTimeEntity(this);

    public final StringPath brand = createString("brand");

    public final StringPath brandEnglish = createString("brandEnglish");

    public final NumberPath<Double> casual = createNumber("casual", Double.class);

    //inherited
    public final DateTimePath<java.time.LocalDateTime> createdAt = _super.createdAt;

    public final StringPath detailCategory = createString("detailCategory");

    public final BooleanPath fall = createBoolean("fall");

    public final NumberPath<Double> fancy = createNumber("fancy", Double.class);

    public final NumberPath<Double> formal = createNumber("formal", Double.class);

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath imgUrl = createString("imgUrl");

    public final StringPath productName = createString("productName");

    public final StringPath productUrl = createString("productUrl");

    public final NumberPath<Short> releaseQuarter = createNumber("releaseQuarter", Short.class);

    public final NumberPath<Short> releaseYear = createNumber("releaseYear", Short.class);

    public final NumberPath<Double> sporty = createNumber("sporty", Double.class);

    public final BooleanPath spring = createBoolean("spring");

    public final StringPath subCategory = createString("subCategory");

    public final BooleanPath summer = createBoolean("summer");

    public final StringPath superCategory = createString("superCategory");

    //inherited
    public final DateTimePath<java.time.LocalDateTime> updatedAt = _super.updatedAt;

    public final BooleanPath winter = createBoolean("winter");

    public QCloth(String variable) {
        super(Cloth.class, forVariable(variable));
    }

    public QCloth(Path<? extends Cloth> path) {
        super(path.getType(), path.getMetadata());
    }

    public QCloth(PathMetadata metadata) {
        super(Cloth.class, metadata);
    }

}

