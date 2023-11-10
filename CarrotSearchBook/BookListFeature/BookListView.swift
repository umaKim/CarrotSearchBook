//
//  BookListView.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/10.
//

import Combine
import UIKit

enum BookListViewAction {
    case updateSearchQuery(String)
}

final class BookListView: UIView {
    private(set) lazy var publisher = subject.eraseToAnyPublisher()
    private let subject = PassthroughSubject<BookListViewAction, Never>()
    
    private(set) var searchController = UISearchController(searchResultsController: nil)
    
    init() {
        super.init(frame: .zero)
        setupSearchController()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BookListView {
    private func setupSearchController() {
        searchController.searchBar.placeholder = "Search Book"
        searchController.searchResultsUpdater = self
    }
}

extension BookListView: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {return }
        subject.send(.updateSearchQuery(text))
    }
}
