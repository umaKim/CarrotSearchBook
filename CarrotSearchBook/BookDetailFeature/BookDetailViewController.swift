//
//  BookDetailViewController.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Combine
import UIKit

final class BookDetailViewController: UIViewController {
    private let contentView = BookDetailView()
    
    private let viewModel: BookDetailViewModel
    
    init(of viewModel: BookDetailViewModel) {
        self.viewModel = viewModel
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
    }
}
