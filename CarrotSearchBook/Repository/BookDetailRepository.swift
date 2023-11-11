//
//  BookDetailRepository.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Foundation

protocol BookDetailRepository {
    func fetchBookDetail(of isbn: String) async throws -> BookDetail
}

final class BookDetailRepositoryImp: BookDetailRepository {
    private let network: BookDetailNetworkable
    
    init(network: BookDetailNetworkable) {
        self.network = network
    }
    
    func fetchBookDetail(of isbn: String) async throws -> BookDetail {
        try await network.fetchBookDetails(of: isbn)
    }
}
