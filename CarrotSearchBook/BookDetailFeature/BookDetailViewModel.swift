//
//  BookDetailViewModel.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Foundation
import Combine

enum BookDetailViewModelListenerType {
    case pop
}

final class BookDetailViewModel {
    private(set) lazy var transitionPublisher   = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject               = PassthroughSubject<BookDetailTransition, Never>()
    
    private let repository: BookDetailRepository
    
    private let isbn: String
    
    init(_ repository: BookDetailRepository, isbn: String) {
        self.repository = repository
        self.isbn = isbn
        
        fetch()
    }
    
    private func fetch() {
        Task { @MainActor in
            let bookDetail = try await repository.fetchBookDetail(of: isbn)
            self.bookDetail = bookDetail
            
            print(bookDetail)
        }
    }
    
    private var bookDetail: BookDetail?
    
    func pop() {
        transitionSubject.send(.pop)
    }
}
