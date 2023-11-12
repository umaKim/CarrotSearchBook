//
//  MockBookListRepository.swift
//  CarrotSearchBookTests
//
//  Created by 김윤석 on 2023/11/12.
//

import Foundation
@testable import CarrotSearchBook

final class MockBookListRepository: BookListRepository {
    var shouldReturnEmpty = false
    var shouldReturnError = false
    var mockBooks: [BookDomain] = [
        .init(id: UUID(), title: "test", subtitle: "test", isbn13: "123", price: "3.00", image: "", url: "test.com")
    ]

    func fetchBooks(for title: String, page: Int) async throws -> BookResponseDomain {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 0, userInfo: nil)
        }

        if shouldReturnEmpty {
            return BookResponseDomain(total: "0", page: "1", books: [])
        } else {
            // Return a predefined set of books or dynamically generate them based on the needs of your test
            return BookResponseDomain(total: "\(mockBooks.count)", page: "\(page)", books: mockBooks)
        }
    }
}
