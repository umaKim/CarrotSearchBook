//
//  AppCoordinator.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Combine
import UIKit

final class AppCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    private(set) lazy var didFinishPublisher: AnyPublisher<Void, Never> = didFinishSubject.eraseToAnyPublisher()
    private let didFinishSubject = PassthroughSubject<Void, Never>()
    private var cancellables = Set<AnyCancellable>()
    
    private let window: UIWindow
    private let container: AppContainer
    
    init(
        window: UIWindow,
        navigationController: UINavigationController = UINavigationController(),
        container: AppContainer
    ){
        self.window = window
        self.navigationController = navigationController
        self.container = container
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        mainFlow()
    }
    
    private func mainFlow() {
        let coordinator = BookListCoordinator(
            navigationController: navigationController,
            container: container
        )
        childCoordinators.append(coordinator)
        coordinator.didFinishPublisher
            .sink {[weak self] in
                guard let self else { return }
                self.removeChild(coordinator: coordinator)
        }
        .store(in: &cancellables)
        coordinator.start()
    }
}
