//
//  Book.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Foundation

public struct BookResponse: Decodable {
    public let error: String?
    public let total: String?
    public let page: String?
    public let books: [Book]
}

public struct Book: Decodable, Hashable {
    public let title: String?
    public let subtitle: String?
    public let isbn13: String?
    public let price: String?
    public let image: String?
    public let url: String?
}
