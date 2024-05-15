//
//  BookDetailBuilder.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//
//import DiManager
import DomainLayer
import UIKit

enum BookDetailTransition: Transition {
    case dismiss
    case moveToLink(String)
}

enum BookDetailBuilder {
    static func build(isbn: String) -> Module<BookDetailTransition, UIViewController> {
        let repository = BookDetailRepositoryImp(network: AppContainerImplementation().network)
//        let repository = DIManager.resolve
        let viewModel = BookDetailViewModel(repository, isbn: isbn)
        let viewController = BookDetailViewController(of: viewModel)
        return Module(
            viewController: viewController,
            transitionPublisher: viewModel.transitionPublisher
        )
    }
}
