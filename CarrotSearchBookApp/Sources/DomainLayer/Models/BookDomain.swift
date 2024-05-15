//
//  BookListDomain.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/12.
//

import Foundation

public struct BookResponseDomain {
    public let total: String?
    public let page: String?
    public let books: [BookDomain]
    
    public init(total: String?, page: String?, books: [BookDomain]) {
        self.total = total
        self.page = page
        self.books = books
    }
}

public struct BookDomain: Hashable {
    public let id: UUID?
    public let title: String?
    public let subtitle: String?
    public let isbn13: String?
    public let price: String?
    public let image: String?
    public let url: String?
    
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
