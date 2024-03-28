package org.palpalmans.ollive_back.domain.board.repository;

import com.querydsl.jpa.impl.JPAQueryFactory;
import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.board.model.entity.Board;
import org.palpalmans.ollive_back.domain.board.model.entity.QBoard;
import org.palpalmans.ollive_back.domain.board.model.entity.QBoardTag;
import org.palpalmans.ollive_back.domain.board.model.entity.QTag;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@RequiredArgsConstructor
public class BoardQueryRepository {
    private final JPAQueryFactory jpaQueryFactory;
    private static final QBoard qBoard = QBoard.board;
    private static final QBoardTag qBoardTag = QBoardTag.boardTag;
    private static final QTag qTag = QTag.tag;

    @Transactional(readOnly = true)
    public List<Board> getBoardList(String keyword, Long lastIndex, int size, List<String> tagNames) {
        return jpaQueryFactory
                .select(qBoard)
                .from(qBoard)
                .leftJoin(qBoardTag).on(qBoard.eq(qBoardTag.board)).fetchJoin()
                .leftJoin(qTag).on(qBoardTag.tag.eq(qTag)).fetchJoin().fetchJoin()
                .where(qBoard.id.gt(lastIndex)
                        .and(keyword == null ? null : qBoard.title.contains(keyword))
                        .and(tagNames.isEmpty() ? null : qTag.name.in(tagNames)))
                .groupBy(qBoard.id)
                .orderBy(qBoard.id.count().desc(), qBoard.id.asc())
                .limit(size)
                .fetch();
    }
}
