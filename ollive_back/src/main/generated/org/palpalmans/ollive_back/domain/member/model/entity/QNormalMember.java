package org.palpalmans.ollive_back.domain.member.model.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QNormalMember is a Querydsl query type for NormalMember
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QNormalMember extends EntityPathBase<NormalMember> {

    private static final long serialVersionUID = 677438337L;

    public static final QNormalMember normalMember = new QNormalMember("normalMember");

    public final QMember _super = new QMember(this);

    //inherited
    public final DateTimePath<java.util.Date> birthday = _super.birthday;

    //inherited
    public final DateTimePath<java.time.LocalDateTime> createdAt = _super.createdAt;

    //inherited
    public final StringPath email = _super.email;

    //inherited
    public final StringPath gender = _super.gender;

    //inherited
    public final NumberPath<Long> id = _super.id;

    //inherited
    public final StringPath name = _super.name;

    //inherited
    public final StringPath nickname = _super.nickname;

    public final StringPath password = createString("password");

    //inherited
    public final StringPath profilePicture = _super.profilePicture;

    //inherited
    public final EnumPath<org.palpalmans.ollive_back.domain.member.model.status.MemberRole> role = _super.role;

    //inherited
    public final DateTimePath<java.time.LocalDateTime> updatedAt = _super.updatedAt;

    public QNormalMember(String variable) {
        super(NormalMember.class, forVariable(variable));
    }

    public QNormalMember(Path<? extends NormalMember> path) {
        super(path.getType(), path.getMetadata());
    }

    public QNormalMember(PathMetadata metadata) {
        super(NormalMember.class, metadata);
    }

}

