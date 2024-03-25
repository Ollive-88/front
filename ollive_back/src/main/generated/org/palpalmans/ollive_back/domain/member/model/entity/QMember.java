package org.palpalmans.ollive_back.domain.member.model.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QMember is a Querydsl query type for Member
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QMember extends EntityPathBase<Member> {

    private static final long serialVersionUID = -1399055430L;

    public static final QMember member = new QMember("member1");

    public final org.palpalmans.ollive_back.common.QBaseTimeEntity _super = new org.palpalmans.ollive_back.common.QBaseTimeEntity(this);

    public final DateTimePath<java.util.Date> birthday = createDateTime("birthday", java.util.Date.class);

    //inherited
    public final DateTimePath<java.time.LocalDateTime> createdAt = _super.createdAt;

    public final StringPath email = createString("email");

    public final StringPath gender = createString("gender");

    public final NumberPath<Long> id = createNumber("id", Long.class);

    public final StringPath name = createString("name");

    public final StringPath nickname = createString("nickname");

    public final StringPath profilePicture = createString("profilePicture");

    public final EnumPath<org.palpalmans.ollive_back.domain.member.model.status.MemberRole> role = createEnum("role", org.palpalmans.ollive_back.domain.member.model.status.MemberRole.class);

    //inherited
    public final DateTimePath<java.time.LocalDateTime> updatedAt = _super.updatedAt;

    public QMember(String variable) {
        super(Member.class, forVariable(variable));
    }

    public QMember(Path<? extends Member> path) {
        super(path.getType(), path.getMetadata());
    }

    public QMember(PathMetadata metadata) {
        super(Member.class, metadata);
    }

}

