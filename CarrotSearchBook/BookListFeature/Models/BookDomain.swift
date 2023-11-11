//
//  BookListDomain.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/12.
//

import Foundation

struct BookResponseDomain: Decodable {
    let total: String?
    let page: String?
    let books: [BookDomain]
}

struct BookDomain: Decodable, Hashable {
    let id: UUID?
    let title: String?
    let subtitle: String?
    let isbn13: String?
    let price: String?
    let image: String?
    let url: String?
}
