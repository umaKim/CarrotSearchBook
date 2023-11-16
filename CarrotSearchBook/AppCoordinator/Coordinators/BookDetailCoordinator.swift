//
//  BookDetailCoordinator.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import SafariServices
import Combine
import UIKit

final class BookDetailCoordinator: Coordinator{
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher: AnyPublisher<Void, Never> = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let container: AppContainer
    private let isbn: String
    
    init(
        navigationController: UINavigationController,
        container: AppContainer,
        isbn: String
    ) {
        self.navigationController = navigationController
        self.container = container
        self.isbn = isbn
    }
    
    func start() {
        let module = BookDetailBuilder.build(container: container, isbn: isbn)
        module
            .transitionPublisher
            .sink { [weak self] transition in
                switch transition {
                case .dismiss:
                    self?.didFinishSubject.send()
                    
                case .moveToLink(let link):
                    self?.presentSafari(of: link)
                }
            }
            .store(in: &cancellables)
        push(module.viewController)
    }
    
    private func presentSafari(of urlString: String) {
        guard let url =  URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemBlue
        present(safariVC)
    }
}
