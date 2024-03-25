package org.palpalmans.ollive_back.domain.member.model.entity;

import static com.querydsl.core.types.PathMetadataFactory.*;

import com.querydsl.core.types.dsl.*;

import com.querydsl.core.types.PathMetadata;
import javax.annotation.processing.Generated;
import com.querydsl.core.types.Path;


/**
 * QSocialMember is a Querydsl query type for SocialMember
 */
@Generated("com.querydsl.codegen.DefaultEntitySerializer")
public class QSocialMember extends EntityPathBase<SocialMember> {

    private static final long serialVersionUID = -1384529529L;

    public static final QSocialMember socialMember = new QSocialMember("socialMember");

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

    //inherited
    public final StringPath profilePicture = _super.profilePicture;

    //inherited
    public final EnumPath<org.palpalmans.ollive_back.domain.member.model.status.MemberRole> role = _super.role;

    public final EnumPath<org.palpalmans.ollive_back.domain.member.model.status.SocialType> socialType = createEnum("socialType", org.palpalmans.ollive_back.domain.member.model.status.SocialType.class);

    //inherited
    public final DateTimePath<java.time.LocalDateTime> updatedAt = _super.updatedAt;

    public QSocialMember(String variable) {
        super(SocialMember.class, forVariable(variable));
    }

    public QSocialMember(Path<? extends SocialMember> path) {
        super(path.getType(), path.getMetadata());
    }

    public QSocialMember(PathMetadata metadata) {
        super(SocialMember.class, metadata);
    }

}

