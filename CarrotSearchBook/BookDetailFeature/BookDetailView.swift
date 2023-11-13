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
    case moveToLink(String)
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
    
    private lazy var urlButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(urlButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    @objc
    private func urlButtonDidTap() {
        guard let url = data?.url else { return }
        subject.send(.moveToLink(url))
    }
    
    private lazy var pdfLinkContainerView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var data: BookDetailDomain?
    
    func configure(with data: BookDetailDomain?) {
        guard let data else { return }
        self.data = data
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
        urlButton.setTitle("Go to Store", for: .normal)
        configurePdfLinkButton(with: data)
    }
    
    private var pdfUrls: [String] = []
    
    private func configurePdfLinkButton(with data: BookDetailDomain?) {
        data?.pdf?.reversed().forEach({ (chapter, url) in
            let button = UIButton(type: .system)
            button.setTitle("\(chapter) Link", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.contentHorizontalAlignment = .left
            button.addTarget(self, action: #selector(pdfButtonTapped(_:)), for: .touchUpInside)
            button.tag = pdfUrls.count
            pdfUrls.append(url)
            pdfLinkContainerView.addArrangedSubview(button)
        })
    }
    
    @objc
    private func pdfButtonTapped(_ sender: UIButton) {
        guard
            sender.tag < pdfUrls.count
        else { return }
        
        let pdfUrl = pdfUrls[sender.tag]
        subject.send(.moveToLink(pdfUrl))
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
            urlButton,
            pdfLinkContainerView
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
