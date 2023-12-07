//
//  BookListRepository.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Foundation

final class BookListRepositoryImp: BookListRepository {
    private let network: BookListNetworkable
    
    init(network: BookListNetworkable) {
        self.network = network
    }
    
    func fetchBooks(for title: String, page: Int) async throws -> BookResponseDomain {
        do {
            let bookresponse = try await network.fetchBooks(for: title, page: page)
            return .init(
                total: bookresponse.total,
                page: bookresponse.page,
                books: bookresponse.books.map({
                    .init(
                        id: UUID(),
                        title: $0.title,
                        subtitle: $0.subtitle,
                        isbn13: $0.isbn13,
                        price: $0.price,
                        image: $0.image,
                        url: $0.url
                    )
                })
            )
        } catch {
            throw error
        }
    }
}
