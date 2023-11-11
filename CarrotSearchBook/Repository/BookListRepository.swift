//
//  BookListRepository.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Foundation

protocol BookListRepository {
    func fetchBooks(for title: String, page: Int) async throws -> BookResponse
}

final class BookListRepositoryImp: BookListRepository {
    private let network: BookListNetworkable
    
    init(network: BookListNetworkable) {
        self.network = network
    }
    
    func fetchBooks(for title: String, page: Int) async throws -> BookResponse {
        try await network.fetchBooks(for: title, page: page)
    }
}
