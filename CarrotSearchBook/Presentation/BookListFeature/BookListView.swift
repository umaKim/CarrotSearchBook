//
//  BookListView.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Combine
import UIKit

enum BookListViewAction {
    case searchButtonClicked(String)
}

final class BookListView: UIView {
    private(set) lazy var publisher = subject.eraseToAnyPublisher()
    private let subject = PassthroughSubject<BookListViewAction, Never>()
    
    private(set) var searchController = UISearchController(searchResultsController: nil)
    
    private(set) var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            BookTableViewCell.self,
            forCellReuseIdentifier: BookTableViewCell.identifier
        )
        tableView.rowHeight = 100
        tableView.keyboardDismissMode = .onDrag
        tableView.backgroundColor = .black
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        setupSearchController()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - paging loading view
extension BookListView {
    func loadingView(status isLoading: Bool) {
        isLoading ? showLoadingView() : hideLoadingView()
    }
    
    private func showLoadingView() {
        let loadingView = LoadingView(frame: .init(origin: .zero, size: .init(width: 100, height: 100)))
        loadingView.start()
        tableView.tableFooterView = loadingView
    }
            
    private func hideLoadingView() {
        tableView.tableFooterView = nil
    }
}

extension BookListView {
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search Book"
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .black
    }
}

//MARK: - UISearchBarDelegate
extension BookListView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        subject.send(.searchButtonClicked(searchText))
    }
}

//MARK: - Set up UI
extension BookListView {
    private func setupUI() {
        [tableView].forEach { uv in
            addSubview(uv)
        }
        tableView.fillSuperview()
    }
}
