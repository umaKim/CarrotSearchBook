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
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        activityIndicator.frame = .init(origin: .zero, size: .init(width: 100, height: 100))
        tableView.tableFooterView = activityIndicator
    }
            
    private func hideLoadingView() {
        tableView.tableFooterView = nil
    }
}

extension BookListView {
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search Book"
        searchController.searchBar.delegate = self
    }
}

extension BookListView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        subject.send(.searchButtonClicked(searchText))
    }
}

extension BookListView {
    private func setupUI() {
        [tableView].forEach { uv in
            addSubview(uv)
            uv.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
