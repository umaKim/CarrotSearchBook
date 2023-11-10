//
//  BookDetailBuilder.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import UIKit

enum BookDetailTransition: Transition {
    case pop
}

final class BookDetailBuilder {
    class func build(container: AppContainer, isbn: String) -> Module<BookDetailTransition, UIViewController> {
        let viewModel = BookDetailViewModel(RepositoryImp(), isbn: isbn)
        let viewController = BookDetailViewController(of: viewModel)
        return Module(
            viewController: viewController,
            transitionPublisher: viewModel.transitionPublisher
        )
    }
}
