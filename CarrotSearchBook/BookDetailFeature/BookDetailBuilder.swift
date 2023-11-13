//
//  BookDetailBuilder.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import UIKit

enum BookDetailTransition: Transition {
    case pop
    case moveToLink(String)
}

final class BookDetailBuilder {
    class func build(container: AppContainer, isbn: String) -> Module<BookDetailTransition, UIViewController> {
        let repository = BookDetailRepositoryImp(network: container.network)
        let viewModel = BookDetailViewModel(repository, isbn: isbn)
        let viewController = BookDetailViewController(of: viewModel)
        return Module(
            viewController: viewController,
            transitionPublisher: viewModel.transitionPublisher
        )
    }
}
