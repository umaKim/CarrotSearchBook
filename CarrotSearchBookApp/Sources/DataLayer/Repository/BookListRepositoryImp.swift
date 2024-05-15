//
//  BookListRepository.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//
import Infrastructure
import Foundation
import DomainLayer

public final class BookListRepositoryImp: BookListRepository {
    private let network: BookListNetworkable
    
    public init(network: BookListNetworkable) {
        self.network = network
    }
    
    public func fetchBooks(for title: String, page: Int) async throws -> BookResponseDomain {
        do {
            let data = try await network.fetchBooks(for: title, page: page)
            let decodedData = try data.decode(to: BookResponse.self)
            return .init(
                total: decodedData.total,
                page: decodedData.page,
                books: decodedData.books.map({
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
