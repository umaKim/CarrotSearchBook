//
//  BookDetailView.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import Combine
import UIKit

enum BookDetailViewAction {
    case pop
}

final class BookDetailView: UIView {
    private(set) lazy var publisher = subject.eraseToAnyPublisher()
    private let subject = PassthroughSubject<BookDetailViewAction, Never>()
    
    private(set) lazy var popButton = UIBarButtonItem(image: .init(systemName: "arrow.backward"), style: .done, target: self, action: #selector(popButtonIsTapped))
    
    @objc
    private func popButtonIsTapped() {
        subject.send(.pop)
    }
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
