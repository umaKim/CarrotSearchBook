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
    case loading(Bool)
    case message(String, String)
}

final class BookListViewModel {
    private(set) lazy var transitionPublisher   = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject               = PassthroughSubject<BookListTransition, Never>()
    
    private(set) lazy var listenPublisher = listenSubject.eraseToAnyPublisher()
    private let listenSubject = PassthroughSubject<BookListViewModelListenerType, Never>()
    
    private(set) var books: [Book] = []
    
    private let repository: BookListRepository
    
    private var currentPage: Int = 1
    private var isLastPageLoaded: Bool = false
    private var isLoading: Bool = false
    
    init(_ repository: BookListRepository) {
        self.repository = repository
    }
    
    private var query: String = ""
    
    func updateQuery(_ title: String) {
        if title == query { return }
        resetData()
        self.query = title
        self.fetchBooks()
    }
    
    private func resetData() {
        books.removeAll()
        currentPage = 1
        isLastPageLoaded = false
    }
    
    func fetchBooks() {
        guard !isLoading, !isLastPageLoaded else { return }
        isLoading = true
        listenSubject.send(.loading(true))
        
        Task { @MainActor in
            do {
                let bookResponse = try await repository.fetchBooks(for: query, page: currentPage)
                if bookResponse.books.isEmpty {
                    self.isLastPageLoaded = true
                } else {
                    self.books += bookResponse.books
                    self.currentPage += 1
                }
                listenSubject.send(.update)
            } catch {
                listenSubject.send(.message("Error", error.localizedDescription))
            }
            isLoading = false
            listenSubject.send(.loading(false))
        }
    }
    
    func moveToBookDetail(_ index: Int) {
        guard let isbn = books[index].isbn13 else { return }
        transitionSubject.send(.bookDetail(isbn))
    }
}
