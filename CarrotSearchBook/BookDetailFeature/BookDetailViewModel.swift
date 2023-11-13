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

protocol BookDetailViewModelInput {
    func viewDidLoad()
    func pop()
    func moveToLink(_ link: String)
}

protocol BookDetailViewModelOutput {
    var listenPublisher: AnyPublisher<BookDetailViewModelListenerType, Never> { get }
    var bookDetail: BookDetailDomain? { get }
}

typealias BookDetailViewModelProtocol = BookDetailViewModelInput & BookDetailViewModelOutput

final class BookDetailViewModel: BookDetailViewModelProtocol {
    
    private(set) lazy var transitionPublisher   = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject               = PassthroughSubject<BookDetailTransition, Never>()
    
    private(set) lazy var listenPublisher = listenSubject.eraseToAnyPublisher()
    private let listenSubject = PassthroughSubject<BookDetailViewModelListenerType, Never>()
    
    private(set) var bookDetail: BookDetailDomain?
    
    private let repository: BookDetailRepository
    private let isbn: String
    
    init(_ repository: BookDetailRepository, isbn: String) {
        self.repository = repository
        self.isbn = isbn
    }
    
    private func fetch() {
        listenSubject.send(.isLoading(true))
        Task { @MainActor in
            do {
                bookDetail = try await repository.fetchBookDetail(of: isbn)
                listenSubject.send(.updateData)
            } catch {
                listenSubject.send(.message("Error", error.localizedDescription))
            }
            listenSubject.send(.isLoading(false))
        }
    }
    
    func viewDidLoad() {
        fetch()
    }
    
    func pop() {
        transitionSubject.send(.pop)
    }
    
    func moveToLink(_ link: String) {
        transitionSubject.send(.moveToLink(link))
    }
}
