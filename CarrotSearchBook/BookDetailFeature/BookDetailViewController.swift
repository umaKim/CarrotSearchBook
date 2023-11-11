//
//  BookDetailViewController.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Combine
import UIKit

final class BookDetailViewController: UIViewController, LoadingShowable, Alertable {
    private let contentView = BookDetailView()
    
    private let viewModel: BookDetailViewModel
    
    private var cancellables: Set<AnyCancellable>
    
    init(of viewModel: BookDetailViewModel) {
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
        
        contentView
            .publisher
            .sink {[weak self] action in
                switch action {
                case .pop:
                    self?.viewModel.pop()
                }
            }
            .store(in: &cancellables)
    }
}
