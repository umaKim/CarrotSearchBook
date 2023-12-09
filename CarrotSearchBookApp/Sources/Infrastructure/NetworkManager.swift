//
//  NetworkManager.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//
//import DataLayer
import Common
import Combine
import Foundation

public protocol BookListNetworkable {
    func fetchBooks(for title: String, page: Int) async throws -> BookResponse
}

public protocol BookDetailNetworkable {
    func fetchBookDetails(of isbn: String) async throws -> BookDetail
}

public typealias NetworkManageable = BookListNetworkable & BookDetailNetworkable

public final class NetworkManager {
    private enum BookApi {
        static let baseUrl = "https://api.itbook.store/1.0/"
    }
    
    private enum BookApiError: Error {
        case noDataReturned
        case invalidResponse
        case invalidUrl
    }
    
    private enum HTTPMethodType: String {
        case get     = "GET"
        case head    = "HEAD"
        case post    = "POST"
        case put     = "PUT"
        case patch   = "PATCH"
        case delete  = "DELETE"
    }
    
    public init() { }
}

extension NetworkManager: BookListNetworkable {
    public func fetchBooks(for title: String, page: Int) async throws -> BookResponse {
        try await request(url: .init(string: "\(BookApi.baseUrl)search/\(title)/\(page)"), method: .get)
    }
}

extension NetworkManager: BookDetailNetworkable {
    public func fetchBookDetails(of isbn: String) async throws -> BookDetail {
        try await request(url: .init(string: "\(BookApi.baseUrl)books/\(isbn)"), method: .get)
    }
}

extension NetworkManager {
    private func request<T: Decodable>(url: URL?, method: HTTPMethodType) async throws -> T {
        guard let url else { throw BookApiError.invalidUrl }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard 
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200
            else { throw BookApiError.invalidResponse }
            let decodedData = try T.decode(from: data)
            return decodedData
        } catch {
            throw error
        }
    }
}
