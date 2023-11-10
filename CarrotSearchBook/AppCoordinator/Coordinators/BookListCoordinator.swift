//
//  BookListCoordinator.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Combine
import UIKit

final class BookListCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher: AnyPublisher<Void, Never> = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let container: AppContainer
    
    init(
        navigationController: UINavigationController,
        container: AppContainer
    ) {
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        let module = BookListBuilder.build(container: container)
        module
            .transitionPublisher
            .sink {[weak self] transition in
                switch transition {
                case .bookDetail(let isbn):
                    self?.bookDetail(for: isbn)
                }
            }
            .store(in: &cancellables)
        setRoot(module.viewController)
    }
    
    private func bookDetail(for isbn: String) {
        let module = BookDetailBuilder.build(container: container, isbn: isbn)
        module
            .transitionPublisher
            .sink { [weak self] transition in
                switch transition {
                case .pop: 
                    self?.pop()
                    self?.didFinishSubject.send()
                    break
                }
            }
            .store(in: &cancellables)
        push(module.viewController)
    }
}
