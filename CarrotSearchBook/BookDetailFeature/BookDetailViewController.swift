//
//  BookDetailViewController.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Combine
import UIKit

final class BookDetailViewController: UIViewController, LoadingShowable {
    private let contentView = BookDetailView()
    
    private let viewModel: BookDetailViewModelProtocol
    
    private var cancellables: Set<AnyCancellable>
    
    init(of viewModel: BookDetailViewModelProtocol) {
        self.viewModel = viewModel
        self.cancellables = .init()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = contentView.popButton
        viewModel.viewDidLoad()
        bindViewToViewController()
        bindViewModelToViewController()
    }
}

//MARK: - Binding
extension BookDetailViewController: Alertable {
    // view -> ViewController
    private func bindViewToViewController() {
        contentView
            .publisher
            .sink {[weak self] action in
                guard let self else { return }
                switch action {
                case .pop:
                    self.viewModel.pop()
                case .moveToLink(let link):
                    self.viewModel.moveToLink(link)
                }
            }
            .store(in: &cancellables)
    }
    
    //ViewModel -> ViewController
    private func bindViewModelToViewController() {
        viewModel
            .listenPublisher
            .sink {[weak self] type in
                guard let self else { return }
                switch type {
                case .isLoading(let isLoading):
                    isLoading ? showLoadingView() : hideLoadingView()
                case .updateData:
                    self.contentView.configure(with: viewModel.bookDetail)
                case .message(let title, let message):
                    self.showDefaultAlert(title: title, message: message)
                }
            }
            .store(in: &cancellables)
    }
}
