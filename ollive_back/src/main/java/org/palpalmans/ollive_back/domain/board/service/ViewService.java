package org.palpalmans.ollive_back.domain.board.service;

import lombok.RequiredArgsConstructor;
import org.palpalmans.ollive_back.domain.board.repository.ViewRepository;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ViewService {
    private final ViewRepository viewRepository;
}
