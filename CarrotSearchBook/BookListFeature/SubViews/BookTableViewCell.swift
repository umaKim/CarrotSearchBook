//
//  BookTableViewCell.swift
//  CarrotSearchBook
//
//  Created by 김윤석 on 2023/11/11.
//

import UIKit

final class BookTableViewCell: UITableViewCell {
    static let identifier = String(describing: BookTableViewCell.self)
    
    private lazy var bookImageView: UIImageView = {
        let uv = UIImageView()
        uv.contentMode = .scaleAspectFit
        uv.widthAnchor.constraint(equalToConstant: 70).isActive = true
        return uv
    }()
    private lazy var titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .boldSystemFont(ofSize: 12)
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 2
        return lb
    }()
    private lazy var subtitleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .white
        lb.font = .systemFont(ofSize: 8)
        lb.minimumScaleFactor = 0.5
        lb.numberOfLines = 2
        return lb
    }()
    private lazy var isbn13Label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 8)
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 1
        return label
    }()
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.minimumScaleFactor = 0.5
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    private lazy var urlLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 8)
        label.minimumScaleFactor = 0.5
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        bookImageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        isbn13Label.text = nil
        priceLabel.text = nil
        urlLabel.text = nil
    }
}

extension BookTableViewCell {
    func configure(with book: BookDomain) {
        bookImageView.downloaded(from: book.image, contentMode: .scaleToFill)
        titleLabel.text = book.title
        subtitleLabel.text = book.subtitle
        isbn13Label.text = book.isbn13
        priceLabel.text = book.price
        urlLabel.text = book.url
    }
}

extension BookTableViewCell {
    private func setupUI() {
        contentView.backgroundColor = .black
        
        let titlesStackView = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, isbn13Label, urlLabel])
        titlesStackView.axis = .vertical
        titlesStackView.alignment = .leading
        titlesStackView.distribution = .fillProportionally
        
        let imageTitlesStackView = UIStackView(arrangedSubviews: [bookImageView, titlesStackView, priceLabel])
        imageTitlesStackView.axis = .horizontal
        imageTitlesStackView.alignment = .fill
        imageTitlesStackView.distribution = .fill
        imageTitlesStackView.spacing = 8
        
        [imageTitlesStackView].forEach { uv in
            addSubview(uv)
            uv.translatesAutoresizingMaskIntoConstraints = false
        }
        
        imageTitlesStackView.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            padding: .init(
                top: 0,
                left: 16,
                bottom: 0,
                right: 16
            )
        )
    }
}
