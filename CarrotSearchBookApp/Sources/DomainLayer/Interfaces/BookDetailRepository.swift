//
//  BookDetailRepository.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/12/07.
//

import Foundation

public protocol BookDetailRepository {
    func fetchBookDetail(of isbn: String) async throws -> BookDetailDomain
}
