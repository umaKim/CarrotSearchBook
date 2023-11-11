//
//  NetworkManager.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//
import Combine
import Foundation

protocol BookListNetworkable {
    func fetchBooks(for title: String, page: Int) async throws -> BookResponse
}

protocol BookDetailNetworkable {
    func fetchBookDetails(of isbn: String) async throws -> BookDetail
}

final class NetworkManager {
    private enum BookApi {
        static let baseUrl = "https://api.itbook.store/1.0/"
    }
    
    private enum BookApiError: Error {
        case noDataReturned
        case invalidUrl
    }
}

extension NetworkManager: BookListNetworkable {
    func fetchBooks(for title: String, page: Int) async throws -> BookResponse {
        try await request(url: .init(string: "\(BookApi.baseUrl)search/\(title)/\(page)"))
    }
}

extension NetworkManager: BookDetailNetworkable {
    func fetchBookDetails(of isbn: String) async throws -> BookDetail {
        try await request(url: .init(string: "\(BookApi.baseUrl)books/\(isbn)"))
    }
}

extension NetworkManager {
    private func request<T: Decodable>(url: URL?) async throws -> T {
        guard let url else { throw BookApiError.invalidUrl }
        let request = URLRequest(url: url)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let decodedData = try T.decode(from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}

