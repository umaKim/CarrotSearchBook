//
//  BookListViewModel.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Foundation
import Combine

final class BookListViewModel {
    private(set) lazy var transitionPublisher   = transitionSubject.eraseToAnyPublisher()
    private let transitionSubject               = PassthroughSubject<BookListTransition, Never>()
    
    private(set) var books: [Book] = []
    
    init() {
        
    }
}
