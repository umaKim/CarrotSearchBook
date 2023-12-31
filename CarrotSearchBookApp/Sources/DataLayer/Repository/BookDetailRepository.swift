//
//  BookDetailRepository.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//
import DomainLayer
import Foundation

final class BookDetailRepositoryImp: BookDetailRepository {
    private let network: BookDetailNetworkable
    
    init(network: BookDetailNetworkable) {
        self.network = network
    }
    
    func fetchBookDetail(of isbn: String) async throws -> BookDetailDomain {
        do {
            let bookDetail = try await network.fetchBookDetails(of: isbn)
            return .init(
                title: "Title: \(bookDetail.title ?? "")",
                subtitle: "Subtitle: \(bookDetail.subtitle ?? "")",
                authors: "Author: \(bookDetail.authors ?? "")",
                publisher: "Publisher: \(bookDetail.publisher ?? "")",
                language: "Language: \(bookDetail.language ?? "")",
                isbn10: "isbn10: \(bookDetail.isbn10 ?? "")",
                isbn13: "isbn13: \(bookDetail.isbn13 ?? "")",
                pages: "Pages: \(bookDetail.pages ?? "")",
                year: "Year: \(bookDetail.year ?? "")",
                rating: "Rating: \(bookDetail.rating ?? "")",
                desc: "Description: \(bookDetail.desc ?? "")",
                price: "Price: \(bookDetail.price ?? "")",
                image: bookDetail.image,
                url: bookDetail.url,
                pdf: bookDetail.pdf ?? [:]
            )
        } catch {
            throw error
        }
    }
}
