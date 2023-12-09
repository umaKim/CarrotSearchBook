//
//  BookListRepository.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/12/07.
//

import Foundation

public protocol BookListRepository {
    func fetchBooks(for title: String, page: Int) async throws -> BookResponseDomain
}
