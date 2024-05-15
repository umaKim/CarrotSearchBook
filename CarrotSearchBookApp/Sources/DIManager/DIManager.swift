//
//  DIManager.swift
//
//
//  Created by 김윤석 on 2023/12/11.
//
import Infrastructure
import DataLayer
import Foundation

public struct DIManager {
    let bookListRepoFactory: () -> BookListRepositoryImp
    let bookDetailRepoFactory: () -> BookDetailRepositoryImp
    
//    public enum ObjectType: String {
//        case bookListRepo
//        case bookDetailRepo
//    }
    
//    init() {
//        store(
//            key: .bookListRepo,
//            object: BookListRepositoryImp(network: NetworkManager())
//        )
//        store(
//            key: .bookDetailRepo,
//            object: BookDetailRepositoryImp(network: NetworkManager())
//        )
//    }
    
    static func resolve() -> Self {
        let bookDetailRepo = BookDetailRepositoryImp(network: NetworkManager())
        let bookListRepo = BookListRepositoryImp(network: NetworkManager())
        
        return .init(
            bookListRepoFactory: bookListRepo,
            bookDetailRepoFactory: bookDetailRepo
        )
    }
    
//    public static let shared = DIManager()
    
//    private var dic: Dictionary<String, AnyObject> = [:]
//    
//    public func store(key: ObjectType, object: AnyObject) {
//        dic[key.rawValue] = object
//    }
//    
//    public func resolve(object: ObjectType) -> AnyObject? {
//        return dic[object.rawValue]
//    }
}
