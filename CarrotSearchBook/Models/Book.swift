//
//  Book.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Foundation

struct BookResponse: Codable {
    let error: String
    let total: String
    let page: String
    let books: [Book]
}

struct Book: Codable, Hashable {
    let title: String
    let subtitle: String
    let isbn13: String
    let price: String
    let image: String
    let url: String
}
