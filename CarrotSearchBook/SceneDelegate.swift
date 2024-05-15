//
//  SceneDelegate.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//
import DataLayer
import PresentationLayer
import DomainLayer
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window                = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene   = windowScene
        
        guard let window else { return }
        let appContainer      = AppContainerImplementation()
        appCoordinator        = AppCoordinator(window: window, container: appContainer)
        appCoordinator?.start()
        
//        DIManager.shared.store(key: "A", object: BookListRepositoryImp())
//        DIManager.shared.store(key: .bookListRepo, object: BookListRepositoryImp())
//        DIManager.shared.store(key: .bookDetailRepo, object: BookDetailRepositoryImp(network: ))
    }
    
//    private var container: Container = {
//       let c = Container()
//        c.register(BookDetailRepository.self, factory: BookDetailRepositoryImp())
//        c.register(BookListRepository.self, factory: BookListRepositoryImp()
//        return c
//    }()
}


public struct Book: Decodable {
    let total: String?
    let page: String?
    let books: [BookA]
    
    public init(total: String?, page: String?, books: [BookA]) {
        self.total = total
        self.page = page
        self.books = books
    }
}

public struct BookA: Decodable, Hashable {
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
