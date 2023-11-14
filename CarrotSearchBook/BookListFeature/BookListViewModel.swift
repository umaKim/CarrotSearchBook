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

protocol BookListViewModelInput {
    func fetchBooks()
    func moveToBookDetail(_ index: Int)
    func updateQuery(_ title: String)
}

protocol BookListViewModelOutput {
    var transitionPublisher: AnyPublisher<BookListTransition, Never> { get }
    var listenPublisher: AnyPublisher<BookListViewModelListenerType, Never> { get }
    var books: [BookDomain] { get }
}

typealias BookListViewModelProtocol = BookListViewModelInput & BookListViewModelOutput

final class BookListViewModel: BookListViewModelProtocol {
    private(set) lazy var transitionPublisher = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject = PassthroughSubject<BookListTransition, Never>()
    
    private(set) lazy var listenPublisher = listenSubject.eraseToAnyPublisher()
    private let listenSubject = PassthroughSubject<BookListViewModelListenerType, Never>()
    
    private(set) var books: [BookDomain] = []
    
    private let repository: BookListRepository
    private var cancellables = Set<AnyCancellable>()
    
    private var currentPage: Int = 1
    private var isLastPageLoaded: Bool = false
    private var isLoading: Bool = false {
        didSet { listenSubject.send(.loading(isLoading)) }
    }
    private var query: String = ""
    
    init(_ repository: BookListRepository) {
        self.repository = repository
    }
}

extension BookListViewModel {
    func updateQuery(_ title: String) {
        guard title != query else { return }
        resetData()
        query = title
        fetchBooks()
    }
    
    func fetchBooks() {
        guard canFetchMoreBooks else { return }
        fetchBookData()
    }
    
    func moveToBookDetail(_ index: Int) {
        guard let isbn = books[index].isbn13 else { return }
        transitionSubject.send(.bookDetail(isbn))
    }
}

extension BookListViewModel {
    private func resetData() {
        books.removeAll()
        currentPage = 1
        isLastPageLoaded = false
    }
    
    private var canFetchMoreBooks: Bool {
        return !isLoading && !isLastPageLoaded
    }
    
    private func fetchBookData() {
        isLoading = true
        Task {@MainActor in
            do {
                let bookResponse = try await repository.fetchBooks(for: query, page: currentPage)
                processBookResponse(bookResponse)
                listenSubject.send(.update)
            } catch {
                listenSubject.send(.message("Error", error.localizedDescription))
            }
            isLoading = false
        }
    }
    
    private func processBookResponse(_ bookResponse: BookResponseDomain) {
        if bookResponse.books.isEmpty {
            handleEmptyResponse()
        } else {
            books += bookResponse.books
            currentPage += 1
        }
        listenSubject.send(.update)
    }
    
    private func handleEmptyResponse() {
        if books.isEmpty {
            listenSubject.send(.message("No Results", "Please try with another key word"))
        } else {
            isLastPageLoaded = true
        }
    }
}
