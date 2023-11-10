//
//  Repository.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Foundation

enum BookApiType: String {
    case search = "search"
    case books = "books"
}

protocol Repository {
    func fetchBooks(for title: String, page: Int) async throws -> BookResponse
    func fetchBookDetail(of isbn: String) async throws -> BookDetail
}

enum BookApiError: Error {
    case failDecode
}

final class RepositoryImp: Repository {
    private enum BookApi {
        static let baseUrl = "https://api.itbook.store/1.0/"
    }
    
    func fetchBooks(for title: String, page: Int) async throws -> BookResponse {
        let urlString = "\(BookApi.baseUrl)search/\(title)/\(page)"
        let request = URLRequest(url: .init(string: urlString)!)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(BookResponse.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
    
    func fetchBookDetail(of isbn: String) async throws -> BookDetail {
        let urlString = "\(BookApi.baseUrl)books/\(isbn)"
        let request = URLRequest(url: .init(string: urlString)!)
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            let decodedData = try JSONDecoder().decode(BookDetail.self, from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
