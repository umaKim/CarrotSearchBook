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
    
    private var currentPage: Int = 1
    private var hasMorePages: Bool = true
    
    init(_ repository: Repository) {
        self.repository = repository
    }
    
    private var query: String = ""
    
    private var isLoading: Bool = false
    
    func updateQuery(_ title: String) {
        self.currentPage = 1
        self.query = title
        self.fetchBooks()
    }
    
    func fetchBooks() {
        if isLoading || query.isEmpty || !hasMorePages { return }
        isLoading = true
        Task { @MainActor in
            let bookResponse = try await repository.fetchBooks(for: query, page: currentPage)
            if bookResponse.books.isEmpty {
                self.hasMorePages = false
            } else {
                self.books += bookResponse.books
                self.currentPage += 1
            }
            self.isLoading = false
            self.listenSubject.send(.update)
        }
    }
    
    func moveToBookDetail(_ index: Int) {
        let isbn = books[index].isbn13
        transitionSubject.send(.bookDetail(isbn))
    }
}
