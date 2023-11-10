//
//  BookListViewModel.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Foundation
import Combine

enum BookListViewModelListenerType {
    case update
}

final class BookListViewModel {
    private(set) lazy var transitionPublisher   = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject               = PassthroughSubject<BookListTransition, Never>()
    
    private(set) lazy var listenPublisher = listenSubject.eraseToAnyPublisher()
    private let listenSubject = PassthroughSubject<BookListViewModelListenerType, Never>()
    
    private(set) var books: [Book] = []
    
    private let repository: Repository
    
    private var page: Int = 1
    
    init(_ repository: Repository) {
        self.repository = repository
        Task {@MainActor in 
            let bookResponse = try await repository.fetchBooks(for: "computer", page: page)
            self.page = Int(bookResponse.page) ?? 1
            self.books = bookResponse.books
            self.listenSubject.send(.update)
        }
    }
}
