//
//  MockBookDetailRepository.swift
//  CarrotSearchBookTests
//
//  Created by 김윤석 on 2023/11/12.
//

import Foundation
@testable import CarrotSearchBook

class MockBookDetailRepository: BookDetailRepository {
    var mockBookDetail: BookDetailDomain?
    var shouldReturnError = false

    func fetchBookDetail(of isbn: String) async throws -> BookDetailDomain {
        if shouldReturnError {
            throw NSError(domain: "TestError", code: 0, userInfo: nil)
        }
        return mockBookDetail ?? BookDetailDomain(title: "", subtitle: "", authors: "", publisher: "", language: "", isbn10: "", isbn13: "", pages: "", year: "", rating: "", desc: "", price: "", image: "", url: "")
    }
}
