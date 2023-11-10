//
//  BookListBuilder.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import UIKit

enum BookListTransition: Transition { }

final class BookListBuilder {
    class func build(container: AppContainer) -> Module<BookListTransition, UIViewController> {
        let viewModel = BookListViewModel(RepositoryImp())
        let viewController = BookListViewController(of: viewModel)
        return Module(
            viewController: viewController,
            transitionPublisher: viewModel.transitionPublisher
        )
    }
}
