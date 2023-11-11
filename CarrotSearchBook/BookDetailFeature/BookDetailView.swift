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
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var publisherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var isbn10Label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var isbn13Label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var pagesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var yearLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
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
    
    func configure(with data: BookDetailDomain?) {
        guard let data else { return }
        bookImageView.downloaded(from: data.image)
        titleLabel.text = data.title
        subtitleLabel.text = data.subtitle
        authorsLabel.text = data.authors
        publisherLabel.text = data.publisher
        languageLabel.text = data.language
        isbn10Label.text = data.isbn10
        isbn13Label.text = data.isbn13
        pagesLabel.text = data.pages
        yearLabel.text = data.year
        ratingLabel.text = data.rating
        descLabel.text = data.desc
        priceLabel.text = data.price
        urlLabel.text = data.url
    }
}

extension BookDetailView {
    private func setupUI() {
        backgroundColor = .black
        
        let labelStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel,
            authorsLabel,
            publisherLabel,
            languageLabel,
            isbn10Label,
            isbn13Label,
            pagesLabel,
            yearLabel,
            ratingLabel,
            descLabel,
            priceLabel,
            urlLabel
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
        totalStackView.distribution = .fill
        totalStackView.alignment = .center
        totalStackView.spacing = 8
        
        [totalStackView].forEach { uv in
            addSubview(uv)
            uv.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            totalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            totalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            totalStackView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            totalStackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
