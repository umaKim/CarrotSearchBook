//
//  BookListDomain.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/12.
//

import Foundation

public struct BookResponseDomain: Decodable {
    let total: String?
    let page: String?
    let books: [BookDomain]
    
    public init(total: String?, page: String?, books: [BookDomain]) {
        self.total = total
        self.page = page
        self.books = books
    }
}

public struct BookDomain: Decodable, Hashable {
    let id: UUID?
    let title: String?
    let subtitle: String?
    let isbn13: String?
    let price: String?
    let image: String?
    let url: String?
    
    public init(id: UUID?, title: String?, subtitle: String?, isbn13: String?, price: String?, image: String?, url: String?) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.isbn13 = isbn13
        self.price = price
        self.image = image
        self.url = url
    }
}
