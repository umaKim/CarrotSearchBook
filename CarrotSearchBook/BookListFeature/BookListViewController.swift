//
//  BookListViewController.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import UIKit

final class BookListViewController: UIViewController {
    private typealias DataSource    = UITableViewDiffableDataSource<Section, Book>
    private typealias Snapshot      = NSDiffableDataSourceSnapshot<Section, Book>
    
    enum Section { case main }
    
    private let contentView = BookListView()
    private var diffableDataSource: DataSource?
    
    private let viewModel: BookListViewModel
    
    init(of viewModel: BookListViewModel) {
        self.viewModel = viewModel
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
    }
}

//MARK: - TableView DiffableDataSource
extension BookListViewController {
    private func setupTableViewDataSource() {
        diffableDataSource = DataSource(tableView: contentView.tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard 
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: "",
                    for: indexPath
                ) as? UITableViewCell
            else { return UITableViewCell() }
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
