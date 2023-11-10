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
