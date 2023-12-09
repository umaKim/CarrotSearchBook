//
//  BookDetail.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Foundation

public struct BookDetail: Decodable {
    let error: String?
    let title: String?
    let subtitle: String?
    let authors: String?
    let publisher: String?
    let language: String?
    let isbn10: String?
    let isbn13: String?
    let pages: String?
    let year: String?
    let rating: String?
    let desc: String?
    let price: String?
    let image: String?
    let url: String?
    let pdf: [String: String]?
    
    public init(error: String?, title: String?, subtitle: String?, authors: String?, publisher: String?, language: String?, isbn10: String?, isbn13: String?, pages: String?, year: String?, rating: String?, desc: String?, price: String?, image: String?, url: String?, pdf: [String : String]?) {
        self.error = error
        self.title = title
        self.subtitle = subtitle
        self.authors = authors
        self.publisher = publisher
        self.language = language
        self.isbn10 = isbn10
        self.isbn13 = isbn13
        self.pages = pages
        self.year = year
        self.rating = rating
        self.desc = desc
        self.price = price
        self.image = image
        self.url = url
        self.pdf = pdf
    }
}
