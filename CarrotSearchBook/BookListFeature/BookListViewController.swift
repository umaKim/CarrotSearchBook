//
//  BookListViewController.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Combine
import UIKit

final class BookListViewController: UIViewController {
    private typealias DataSource    = UITableViewDiffableDataSource<Section, BookDomain>
    private typealias Snapshot      = NSDiffableDataSourceSnapshot<Section, BookDomain>
    
    enum Section { case main }
    
    private let contentView = BookListView()
    private var diffableDataSource: DataSource?
    
    private let viewModel: BookListViewModelProtocol
    
    private var cancellables: Set<AnyCancellable>
    
    init(of viewModel: BookListViewModelProtocol) {
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

//MARK: - Binding
extension BookListViewController: Alertable {
    // view -> ViewController
    private func bindViewToViewController() {
        contentView
            .publisher
            .sink {[weak self] action in
                guard let self else { return }
                switch action {
                case .searchButtonClicked(let query):
                    self.viewModel.updateQuery(query) {
                        UIImageView.cache.removeAllObjects()
                    }
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
                case .update:
                    self.updateData()
                case .loading(let isLoading):
                    self.contentView.loadingView(status: isLoading)
                case .message(let title, let message):
                    self.showDefaultAlert(title: title, message: message)
                }
            }
            .store(in: &cancellables)
    }
}

//MARK: - UIScrollViewDelegate
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
        contentView.tableView.prefetchDataSource = self
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

//MARK: - UITableViewDataSourcePrefetching
extension BookListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            let imageUrl = viewModel.books[indexPath.row].image
            UIImageView().downloaded(from: imageUrl)
        }
    }
}

//MARK: - UITableViewDelegate
extension BookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.moveToBookDetail(indexPath.item)
    }
}
