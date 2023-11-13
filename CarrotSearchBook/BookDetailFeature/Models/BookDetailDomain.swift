//
//  BookDetailDomain.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/12.
//

import Foundation

struct BookDetailDomain: Equatable {
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
}
