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
    
    private(set) var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    private let contentView = UIView()
    
    private lazy var bookImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
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
        button.setTitleColor(.tintColor, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
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
        stackView.alignment = .center
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
        pdfUrls = []
        data?.pdf?.forEach { (chapter, url) in
            let button = createPDFButton(chapter: chapter, url: url)
            button.tag = pdfUrls.count
            pdfUrls.append(url)
            pdfLinkContainerView.addArrangedSubview(button)
        }
    }
    
    private func createPDFButton(chapter: String, url: String) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle("\(chapter) Link", for: .normal)
        button.setTitleColor(.tintColor, for: .normal)
        button.contentHorizontalAlignment = .left
        button.addTarget(self, action: #selector(pdfButtonTapped(_:)), for: .touchUpInside)
        return button
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
        addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
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
        labelStackView.distribution = .fill
        labelStackView.alignment = .fill
        labelStackView.spacing = 8
        
        let totalStackView = UIStackView(arrangedSubviews: [
            bookImageView,
            labelStackView
        ])
        totalStackView.axis = .vertical
        totalStackView.distribution = .fill
        totalStackView.alignment = .fill
        totalStackView.spacing = 8
        
        [totalStackView].forEach { uv in
            uv.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(uv)
        }
        
        contentScrollView.anchor(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            bottom: safeAreaLayoutGuide.bottomAnchor,
            trailing: trailingAnchor
        )
        
        contentView.anchor(
            top: contentScrollView.topAnchor,
            leading: contentScrollView.leadingAnchor,
            bottom: contentScrollView.bottomAnchor,
            trailing: contentScrollView.trailingAnchor
        )
        
        contentView.constrainWidth(
            constant: UIScreen.main.bounds.width
        )
        
        totalStackView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            padding: .init(
                top: 0,
                left: 16,
                bottom: 32,
                right: 16
            )
        )
    }
}
