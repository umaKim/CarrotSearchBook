//
//  BookDetailViewModel.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Foundation
import Combine

enum BookDetailViewModelListenerType {
    case isLoading(Bool)
    case updateData
    case message(String, String)
}

struct BookDetailDomain {
    let title: String?
    let subtitle: String?
    let authors: String?
    let publisher: String?
    let language: String?
    let isbn10: String?
    let isbn13: String?
    let pages: String?
    let year: String?
    let rating: String?
    let desc: String?
    let price: String?
    let image: String?
    let url: String?
}

final class BookDetailViewModel {
    private(set) lazy var transitionPublisher   = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject               = PassthroughSubject<BookDetailTransition, Never>()
    
    private(set) lazy var listenPublisher = listenSubject.eraseToAnyPublisher()
    private let listenSubject = PassthroughSubject<BookDetailViewModelListenerType, Never>()
    
    private let repository: BookDetailRepository
    private(set) var bookDetail: BookDetailDomain?
    
    private let isbn: String
    
    init(_ repository: BookDetailRepository, isbn: String) {
        self.repository = repository
        self.isbn = isbn
        
        fetch()
    }
    
    private func fetch() {
        listenSubject.send(.isLoading(true))
        Task { @MainActor in
            do {
                let bookDetail = try await repository.fetchBookDetail(of: isbn)
                self.bookDetail = bookDetail
                listenSubject.send(.updateData)
            } catch {
                listenSubject.send(.message("Error", error.localizedDescription))
            }
            listenSubject.send(.isLoading(false))
        }
    }
    
    func pop() {
        transitionSubject.send(.pop)
    }
}
