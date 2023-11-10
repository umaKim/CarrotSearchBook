//
//  BookListViewController.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Combine
import UIKit

final class BookListViewController: UIViewController {
    private typealias DataSource    = UITableViewDiffableDataSource<Section, Book>
    private typealias Snapshot      = NSDiffableDataSourceSnapshot<Section, Book>
    
    enum Section { case main }
    
    private let contentView = BookListView()
    private var diffableDataSource: DataSource?
    
    private let viewModel: BookListViewModel
    
    private var cancellables: Set<AnyCancellable>
    
    init(of viewModel: BookListViewModel) {
        self.viewModel = viewModel
        self.cancellables = .init()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Life Cycle
extension BookListViewController {
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = contentView.searchController
        contentView.tableView.delegate = self
        setupTableViewDataSource()
        bindViewToViewController()
        bindViewModelToViewController()
    }
}

extension BookListViewController {
    private func bindViewToViewController() {
        contentView
            .publisher.sink { action in
                switch action {
                case .searchButtonClicked(let query):
                    self.viewModel.updateQuery(query)
                }
            }
            .store(in: &cancellables)
    }
    
    private func bindViewModelToViewController() {
        viewModel
            .listenPublisher
            .sink {[weak self] type in
                guard let self else { return }
                switch type {
                case .update:
                    self.updateData()
                }
            }
            .store(in: &cancellables)
    }
}

extension BookListViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            viewModel.fetchBooks()
        }
    }
}

//MARK: - TableView DiffableDataSource
extension BookListViewController {
    private func setupTableViewDataSource() {
        diffableDataSource = DataSource(tableView: contentView.tableView, cellProvider: {[weak self] tableView, indexPath, itemIdentifier in
            guard
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: BookTableViewCell.identifier,
                    for: indexPath
                ) as? BookTableViewCell,
                let self
            else { return UITableViewCell() }
            cell.configure(with: self.viewModel.books[indexPath.item])
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.books)
        self.diffableDataSource?.apply(snapshot, animatingDifferences: true)
    }
}

//MARK: - UITableViewDelegate
extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
