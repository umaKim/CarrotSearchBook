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
    
    private lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var publisherLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with data: BookDetail?) {
        guard let data else { return }
        bookImageView.downloaded(from: data.image!)
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        authorsLabel.text = data.authors
        publisherLabel.text = data.publisher
    }
}

extension BookDetailView {
    private func setupUI() {
        backgroundColor = .black
        
        let labelStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            authorsLabel,
            publisherLabel
        ])
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillProportionally
        labelStackView.alignment = .center
        labelStackView.spacing = 8
        
        let totalStackView = UIStackView(arrangedSubviews: [
            bookImageView,
            labelStackView
        ])
        totalStackView.axis = .vertical
        totalStackView.distribution = .fillEqually
        totalStackView.alignment = .center
        totalStackView.spacing = 8
        
        [totalStackView].forEach { uv in
            addSubview(uv)
            uv.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            totalStackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
